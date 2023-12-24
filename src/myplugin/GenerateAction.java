package myplugin;

import java.awt.event.ActionEvent;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import com.nomagic.magicdraw.actions.MDAction;
import com.nomagic.magicdraw.core.Application;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import myplugin.analyzer.AnalyzeException;
import myplugin.analyzer.ModelAnalyzer;
import myplugin.generator.BasicGenerator;
import myplugin.generator.ControllerGenerator;
import myplugin.generator.DTOGenerator;
import myplugin.generator.DataMapperGenerator;
import myplugin.generator.EJBGenerator;
import myplugin.generator.EnumGenerator;
import myplugin.generator.FEDeleteHtmlGenerator;
import myplugin.generator.FEDeleteScssGenerator;
import myplugin.generator.FEDeleteTsGenerator;
import myplugin.generator.FEEditHtmlGenerator;
import myplugin.generator.FEEditScssGenerator;
import myplugin.generator.FEEditTsGenerator;
import myplugin.generator.FEItemsScssGenerator;
import myplugin.generator.FEItemsTsGenerator;
import myplugin.generator.FELayoutComponentGenerator;
import myplugin.generator.FELayoutHtmlGenerator;
import myplugin.generator.FEModelGenerator;
import myplugin.generator.FEViewHtmlGenerator;
import myplugin.generator.FEViewScssGenerator;
import myplugin.generator.FEViewTsGenerator;
import myplugin.generator.ModelGenerator;
import myplugin.generator.FERoutingGenerator;
import myplugin.generator.FEServiceGenerator;
import myplugin.generator.FETsGenerator;
import myplugin.generator.PomGenerator;
import myplugin.generator.RepositoryGenerator;
import myplugin.generator.ServiceGenerator;
import myplugin.generator.SpringApplicationGenerator;
import myplugin.generator.StaticFilesGenerator;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;

/** Action that activate code generation */
@SuppressWarnings("serial")
class GenerateAction extends MDAction {

	private static final String PACKAGE_PREFIX = "uns.ac.rs.mbrs";
	private static final String STATIC_FILE_PREFIX = "resources/static";
	
	public GenerateAction(String name) {
		super("", name, null, null);
	}

	public void actionPerformed(ActionEvent evt) {

		if (Application.getInstance().getProject() == null)
			return;
		Package root = Application.getInstance().getProject().getModel();

		if (root == null)
			return;

		ModelAnalyzer analyzer = new ModelAnalyzer(root, "ejb");

		try {
			analyzer.prepareModel();
			this.generateComponent(root, PACKAGE_PREFIX, "RepositoryGenerator");
			 
			this.generateComponent(root, PACKAGE_PREFIX, "SpringApplicationGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "ControllerGenerator");
			this.generateComponent(root, "", "PomGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "DataMapperGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "EnumGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "ServiceGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "ModelGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "DTOGenerator");

			// FrontEnd Application
			this.generateComponent(root, PACKAGE_PREFIX, "FEModelGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "FEServiceGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorDeleteHTML");
			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorDeleteSCSS");
			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorDeleteTS");

			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorViewHTML");
			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorViewSCSS");
			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorViewTS");

			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorEditHTML");
			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorEditSCSS");
			this.generateComponent(root, PACKAGE_PREFIX, "FEGeneratorEditTS");

			this.generateComponent(root, PACKAGE_PREFIX, "FERoutingGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "FETsGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "FELayoutComponentGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "FELayoutHtmlGenerator");
			
			this.generateComponent(root, PACKAGE_PREFIX, "FEItemsHtmlGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "FEItemsScssGenerator");
			this.generateComponent(root, PACKAGE_PREFIX, "FEItemsTsGenerator");
	
			// Static files
			this.generateStaticFiles(STATIC_FILE_PREFIX);

			// TODO folder name
			JOptionPane.showMessageDialog(null,
					"Code is successfully generated! Generated code is in folder: c:/generated");
//			+ go.getOutputPath() + ", package: " + go.getFilePackage());
			exportToXml();
		} catch (AnalyzeException | IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
	}

	private void generateStaticFiles(String staticFilePrefix) throws IOException {
		
		StaticFilesGenerator.copy(staticFilePrefix + "/frontend", "C:/generated/frontend");
		StaticFilesGenerator.copy(staticFilePrefix + "/frontend/src", "C:/generated/frontend/src");
		StaticFilesGenerator.copy(staticFilePrefix + "/frontend/src/app", "C:/generated/frontend/src/app");
	}

	private void exportToXml() {
		if (JOptionPane.showConfirmDialog(null, "Do you want to save FM Model?") == JOptionPane.OK_OPTION) {
			JFileChooser jfc = new JFileChooser();
			if (jfc.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
				String fileName = jfc.getSelectedFile().getAbsolutePath();

				XStream xstream = new XStream(new DomDriver());
				BufferedWriter out;
				try {
					out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileName), "UTF8"));
					xstream.toXML(FMModel.getInstance().getClasses(), out);
					xstream.toXML(FMModel.getInstance().getEnumerations(), out);

				} catch (UnsupportedEncodingException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());
				} catch (FileNotFoundException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());
				}
			}
		}
	}

	private void generateComponent(Package root, String packageName, String generatorName)
			throws AnalyzeException, IOException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, packageName);
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get(generatorName);
		BasicGenerator generator;

		switch (generatorName) {
			case "EJBGenerator":
				generator = new EJBGenerator(generatorOptions);
				break;
			case "ControllerGenerator":
				generator = new ControllerGenerator(generatorOptions);
				break;
			case "PomGenerator":
				generator = new PomGenerator(generatorOptions);
				break;
			case "DataMapperGenerator":
				generator = new DataMapperGenerator(generatorOptions);
				break;
			case "RepositoryGenerator":
				generator = new RepositoryGenerator(generatorOptions);
				break;
			case "ServiceGenerator":
				generator = new ServiceGenerator(generatorOptions);
				break;
			case "SpringApplicationGenerator":
				generator = new SpringApplicationGenerator(generatorOptions);
				break;
			case "EnumGenerator":
				generator = new EnumGenerator(generatorOptions);
				break;
			case "ModelGenerator":
				generator = new ModelGenerator(generatorOptions);
				break;
			case "DTOGenerator":
				generator = new DTOGenerator(generatorOptions);
				break;
			case "FEModelGenerator":
				generator = new FEModelGenerator(generatorOptions);
				break;
			case "FEGeneratorDeleteHTML":
				generator = new FEDeleteHtmlGenerator(generatorOptions);
				break;
			case "FEGeneratorDeleteSCSS":
				generator = new FEDeleteScssGenerator(generatorOptions);
				break;
			case "FEGeneratorDeleteTS":
				generator = new FEDeleteTsGenerator(generatorOptions);
				break;
			case "FEGeneratorViewHTML":
				generator = new FEViewHtmlGenerator(generatorOptions);
				break;
			case "FEGeneratorViewSCSS":
				generator = new FEViewScssGenerator(generatorOptions);
				break;
			case "FEGeneratorViewTS":
				generator = new FEViewTsGenerator(generatorOptions);
				break;
			case "FEGeneratorEditHTML":
				generator = new FEEditHtmlGenerator(generatorOptions);
				break;
			case "FEGeneratorEditSCSS":
				generator = new FEEditScssGenerator(generatorOptions);
				break;
			case "FEGeneratorEditTS":
				generator = new FEEditTsGenerator(generatorOptions);
				break;
			case "FERoutingGenerator":
				generator = new FERoutingGenerator(generatorOptions);
				break;
			case "FELayoutComponentGenerator":
				generator = new FELayoutComponentGenerator(generatorOptions);
				break;
			case "FELayoutHtmlGenerator":
				generator = new FELayoutHtmlGenerator(generatorOptions);
				break;
			case "FEItemsHtmlGenerator":
				generator = new FETsGenerator(generatorOptions);
				break;
			case "FEItemsScssGenerator":
				generator = new FEItemsScssGenerator(generatorOptions);
				break;
			case "FEItemsTsGenerator":
				generator = new FEItemsTsGenerator(generatorOptions);
				break;
			case "FETsGenerator":
				generator = new FETsGenerator(generatorOptions);
				break;
			case "FEServiceGenerator":
				generator = new FEServiceGenerator(generatorOptions);
				break;
			default:
				throw new IllegalArgumentException("Unknown generator " + generatorName);
		}

		generator.generate();
	}

}