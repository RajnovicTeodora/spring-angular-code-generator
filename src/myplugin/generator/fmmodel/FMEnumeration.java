package myplugin.generator.fmmodel;

import java.util.ArrayList;
import java.util.Iterator;

public class FMEnumeration extends FMType {
	private ArrayList <String> values = new ArrayList<String>();
	
	public FMEnumeration(String name, String typePackage) {
		super(name, typePackage);
	}
	
	public ArrayList<String> getValues() {
		return values;
	}

	public void setValues(ArrayList<String> values) {
		this.values = values;
	}

	public Iterator<String> getValueIterator(){
		return values.iterator();
	}
	
	public void addValue(String value){
		values.add(value);		
	}
	
	public int getvaluesCount(){
		return values.size();
	}

	public String getValueAt(int i){
		return values.get(i);
	}
	
}