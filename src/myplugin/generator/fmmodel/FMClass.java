package myplugin.generator.fmmodel;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


public class FMClass extends FMType {	
	
	private String visibility;
	//private FMEntity entity = null;
	private String tableName;

	//Class properties
	private List<FMProperty> FMProperties = new ArrayList<FMProperty>();
	private List<FMReferenceProperty> referenceProperties = new ArrayList<FMReferenceProperty>();
	private List<FMPrimitiveProperty> primitiveProperties = new ArrayList<FMPrimitiveProperty>();
	//list of packages (for import declarations) 
	private List<String> importedPackages = new ArrayList<String>();
	
	/** @ToDo: add list of methods */
	
	
	public FMClass(String name, String classPackage, String visibility) {
		super(name, classPackage);		
		this.visibility = visibility;
	}	
	
	public List<FMProperty> getProperties(){
		return FMProperties;
	}
	
	public Iterator<FMProperty> getPropertyIterator(){
		return FMProperties.iterator();
	}
	
	public void addProperty(FMProperty property){
		FMProperties.add(property);		
	}
	
	public int getPropertyCount(){
		return FMProperties.size();
	}
	
	public List<String> getImportedPackages(){
		return importedPackages;
	}

	public Iterator<String> getImportedIterator(){
		return importedPackages.iterator();
	}
	
	public void addImportedPackage(String importedPackage){
		importedPackages.add(importedPackage);		
	}
	
	public int getImportedCount(){
		return FMProperties.size();
	}
	
	public String getVisibility() {
		return visibility;
	}

	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}

	public List<FMReferenceProperty> getReferenceProperties() {
		return referenceProperties;
	}
	
	public void addReferenceProperty(FMReferenceProperty property){
		referenceProperties.add(property);		
	}

	public void setReferenceProperties(List<FMReferenceProperty> referenceProperties) {
		this.referenceProperties = referenceProperties;
	}

	public List<FMPrimitiveProperty> getPrimitiveProperties() {
		return primitiveProperties;
	}
	
	public void addPrimitiveProperty(FMPrimitiveProperty property){
		primitiveProperties.add(property);		
	}

	public void setPrimitiveProperties(List<FMPrimitiveProperty> primitiveProperties) {
		this.primitiveProperties = primitiveProperties;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}	

	
	
}
