package myplugin.analyzer;

import java.util.Iterator;
import java.util.List;

import javax.swing.JOptionPane;

import myplugin.generator.fmmodel.CascadeType;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMEntity;
import myplugin.generator.fmmodel.FMEnumeration;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMPrimitiveProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.fmmodel.FMReferenceProperty;
import myplugin.generator.fmmodel.FetchType;
import myplugin.generator.fmmodel.GenerationType;

import com.nomagic.uml2.ext.jmi.helpers.ModelHelper;
import com.nomagic.uml2.ext.jmi.helpers.StereotypesHelper;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.EnumerationLiteral;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Class;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Enumeration;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Property;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.impl.EnumerationLiteralImpl;
import com.nomagic.uml2.ext.magicdraw.mdprofiles.Stereotype;

/**
 * Model Analyzer takes necessary metadata from the MagicDraw model and puts it
 * in the intermediate data structure (@see myplugin.generator.fmmodel.FMModel)
 * optimized for code generation using freemarker. Model Analyzer now takes
 * metadata only for ejb code generation
 * 
 * @ToDo: Enhance (or completely rewrite) myplugin.generator.fmmodel classes and
 *        Model Analyzer methods in order to support GUI generation.
 */

public class ModelAnalyzer {
	// root model package
	private Package root;

	// java root package for generated code
	private String filePackage;

	public ModelAnalyzer(Package root, String filePackage) {
		super();
		this.root = root;
		this.filePackage = filePackage;
	}

	public Package getRoot() {
		return root;
	}

	public void prepareModel() throws AnalyzeException {
		FMModel.getInstance().getClasses().clear();
		FMModel.getInstance().getEnumerations().clear();
		processPackage(root, filePackage);
	}

	private void processPackage(Package pack, String packageOwner) throws AnalyzeException {
		// Recursive procedure that extracts data from package elements and stores it in
		// the
		// intermediate data structure

		if (pack.getName() == null)
			throw new AnalyzeException("Packages must have names!");

		String packageName = packageOwner;
		if (pack != root) {
			packageName += "." + pack.getName();
		}

		if (pack.hasOwnedElement()) {

			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				if (ownedElement instanceof Class) {
					Class cl = (Class) ownedElement;
					FMClass fmClass = getClassData(cl, packageName);
					fmClass.setName(fmClass.getName().replaceAll(" ", ""));
					FMModel.getInstance().getClasses().add(fmClass);
				}

				if (ownedElement instanceof Enumeration) {
					Enumeration en = (Enumeration) ownedElement;
					FMEnumeration fmEnumeration = getEnumerationData(en, packageName);
					FMModel.getInstance().getEnumerations().add(fmEnumeration);
				}
			}

			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				if (ownedElement instanceof Package) {
					Package ownedPackage = (Package) ownedElement;
					if (StereotypesHelper.getAppliedStereotypeByString(ownedPackage, "BusinessApp") != null)
						// only packages with stereotype BusinessApp are candidates for metadata
						// extraction and code generation:
						processPackage(ownedPackage, packageName);
				}
			}

			/**
			 * @ToDo: Process other package elements, as needed
			 */
		}
	}

	private FMClass getClassData(Class cl, String packageName) throws AnalyzeException {
		if (cl.getName() == null)
			throw new AnalyzeException("Classes must have names!");

		FMClass fmClass = new FMClass(cl.getName(), packageName, cl.getVisibility().toString());
		Iterator<Property> it = ModelHelper.attributes(cl);
		while (it.hasNext()) {
			Property p = it.next();

			if (p.getOpposite() != null) {
				FMReferenceProperty refProp = getReferencePropertyData(p, cl);
				refProp.setName(refProp.getName().replace(" ", ""));
				fmClass.addReferenceProperty(refProp);
				fmClass.addProperty(refProp);
			} else {
				FMPrimitiveProperty primProp = getPrimitivePropertyData(p, cl);
				primProp.setName(primProp.getName().replace(" ", ""));
				fmClass.addPrimitiveProperty(primProp);
				fmClass.addProperty(primProp);
			}
		}

		/**
		 * @ToDo: Add import declarations etc.
		 */

		Stereotype entityStereotype = StereotypesHelper.getAppliedStereotypeByString(cl, "Entity");
		if (entityStereotype != null) {
			String tableName = "";
			List<Property> tags = entityStereotype.getOwnedAttribute();
			for (int j = 0; j < tags.size(); ++j) {
				Property tagDef = tags.get(j);
				String tagName = tagDef.getName();
				List value = StereotypesHelper.getStereotypePropertyValue(cl, entityStereotype, tagName);
				if (value.size() > 0) {
					switch (tagName) {
					case "tableName":
						tableName = (String) value.get(0);
						break;
					}
				}
			}
			fmClass.setTableName(tableName);
		}

		return fmClass;
	}

	private FMPrimitiveProperty getPrimitivePropertyData(Property p, Class cl) throws AnalyzeException {
		PropertyMapper prop = getPropertyData(p, cl);
		Stereotype primitiveStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "PrimitiveProperty");
		String columnName = null;
		Boolean unique = null;
		Integer length = null;
		GenerationType generationType = null;
		String frontType = null;
		if (primitiveStereotype != null) {
			List<Property> tags = primitiveStereotype.getOwnedAttribute();
			for (int j = 0; j < tags.size(); ++j) {
				Property tagDef = tags.get(j);
				String tagName = tagDef.getName();
				List value = StereotypesHelper.getStereotypePropertyValue(p, primitiveStereotype, tagName);
				if (value.size() > 0) {
					switch (tagName) {
					case "columnName":
						columnName = (String) value.get(0);
						break;
					case "unique":
						unique = (Boolean) value.get(0);
						break;
					case "length":
						length = (Integer) value.get(0);
						break;
					case "generationType":
						EnumerationLiteralImpl genType = (EnumerationLiteralImpl) value.get(0);
						generationType = GenerationType.valueOf(genType.getName());
						break;
					case "frontType":
						frontType = (String) value.get(0);
						break;
					}
				}
			}
		}
		Boolean isId = false;
		if (generationType != null && generationType.toString().contains("IDENTITY")) {
			isId = generationType.name().equalsIgnoreCase("IDENTITY");
		}
		FMPrimitiveProperty primProp = new FMPrimitiveProperty(prop.getAttName(), prop.getTypeName(),
				p.getVisibility().toString(), p.getLower(), p.getUpper(), columnName, generationType, length, isId,
				unique, frontType);

		return primProp;
	}

	private FMReferenceProperty getReferencePropertyData(Property p, Class cl) throws AnalyzeException {
		PropertyMapper property = getPropertyData(p, cl);
		Stereotype referenceStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "ReferenceProperty");
		CascadeType cascadeType = null;
		FetchType fetchType = null;
		String mappedBy = null;
		if (referenceStereotype != null) {
			List<Property> tags = referenceStereotype.getOwnedAttribute();
			for (int j = 0; j < tags.size(); ++j) {
				Property tagDef = tags.get(j);
				String tagName = tagDef.getName();
				List value = StereotypesHelper.getStereotypePropertyValue(p, referenceStereotype, tagName);
				if (value.size() > 0) {
					switch (tagName) {
					case "cascade":
						EnumerationLiteralImpl casc = (EnumerationLiteralImpl) value.get(0);
						cascadeType = CascadeType.valueOf(casc.getName());
						break;
					case "fetchType":
						EnumerationLiteralImpl fType = (EnumerationLiteralImpl) value.get(0);
						fetchType = FetchType.valueOf(fType.getName());
						break;
					case "mappedBy":
						mappedBy = (String) value.get(0);
						break;
					}
				}
			}
		}

		int oppositeEnd = p.getOpposite().getUpper();
		FMReferenceProperty refProp = new FMReferenceProperty(property.getAttName(), property.getTypeName(),
				p.getVisibility().toString(), property.getLower(), property.getUpper(), mappedBy, cascadeType,
				fetchType);
		return refProp;
	}

	private FMEnumeration getEnumerationData(Enumeration enumeration, String packageName) throws AnalyzeException {
		FMEnumeration fmEnum = new FMEnumeration(enumeration.getName(), packageName);
		List<EnumerationLiteral> list = enumeration.getOwnedLiteral();
		for (int i = 0; i < list.size() - 1; i++) {
			EnumerationLiteral literal = list.get(i);
			if (literal.getName() == null)
				throw new AnalyzeException("Items of the enumeration " + enumeration.getName() + " must have names!");
			fmEnum.addValue(literal.getName());
		}
		return fmEnum;
	}

	private PropertyMapper getPropertyData(Property p, Class cl) throws AnalyzeException {
		PropertyMapper prop = new PropertyMapper(p.getName(), p.getType(), p.getType().getName(), p.getLower(),
				p.getUpper());
		if (prop.getAttName() == null)
			throw new AnalyzeException("Properties of the class: " + cl.getName() + " must have names!");
		if (prop.getAttType() == null)
			throw new AnalyzeException("Property " + cl.getName() + "." + p.getName() + " must have type!");
		if (prop.getTypeName() == null)
			throw new AnalyzeException("Type ot the property " + cl.getName() + "." + p.getName() + " must have name!");
		return prop;
	}
}
