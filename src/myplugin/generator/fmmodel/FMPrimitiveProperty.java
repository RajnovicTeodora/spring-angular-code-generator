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
			GenerationType generationType, Integer length, Boolean isId, Boolean unique, String frontType, Boolean isEnum) {
		super(name, type, visibility, lower, upper);
		this.columnName = columnName;
		this.generationType = generationType;
		this.length = length;
		this.isId = isId;
		this.unique = unique;
		this.frontType = frontType;
		this.isEnum = isEnum;
	}

	private String columnName;
	private GenerationType generationType;
	private Integer length;
	private Boolean isId;
	private Boolean unique;
	private String frontType;
	private Boolean isEnum;

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

	public String getFrontType() {
		return frontType;
	}

	public void setFrontType(String frontType) {
		this.frontType = frontType;
	}

	public Boolean getIsEnum() {
		return isEnum;
	}

	public void setIsEnum(Boolean isEnum) {
		this.isEnum = isEnum;
	}

}
