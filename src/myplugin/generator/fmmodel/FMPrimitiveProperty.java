package myplugin.generator.fmmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FMPrimitiveProperty extends FMBackendProperty {

	public FMPrimitiveProperty(String name, String type, String visibility, int lower, int upper) {
		super(name, type, visibility, lower, upper);

	}

	public FMPrimitiveProperty(String name, String type, String visibility, int lower, int upper, String columnName,
			GenerationType generationType, Integer length, Boolean isId, Boolean unique) {
		super(name, type, visibility, lower, upper);
		this.columnName = columnName;
		this.generationType = generationType;
		this.length = length;
		this.isId = isId;
		this.unique = unique;
	}

	private String columnName;
	public GenerationType generationType;
	private Integer length;
	public Boolean isId;
	private Boolean unique;
	
	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public GenerationType getGenerationType() {
		return generationType;
	}

	public void setGenerationType(GenerationType generationType) {
		this.generationType = generationType;
	}

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public Boolean getIsId() {
		return isId;
	}

	public void setIsId(Boolean isId) {
		this.isId = isId;
	}

	public Boolean getUnique() {
		return unique;
	}

	public void setUnique(Boolean unique) {
		this.unique = unique;
	}
	
	
}
