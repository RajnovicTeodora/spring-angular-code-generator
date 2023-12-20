package myplugin.generator.fmmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FMReferenceProperty extends FMBackendProperty {

	public FMReferenceProperty(String name, String type, String visibility, int lower, int upper) {
		super(name, type, visibility, lower, upper);
	}

	public FMReferenceProperty(String name, String type, String visibility, int lower, int upper, String mappedBy,
			CascadeType cascadeType, FetchType fetchType, String cardinality) {
		super(name, type, visibility, lower, upper);
		this.mappedBy = mappedBy;
		this.cascadeType = cascadeType;
		this.fetchType = fetchType;
		this.cardinality = cardinality;
	}

	private String mappedBy;
	private CascadeType cascadeType;
	private FetchType fetchType;
	private String cardinality;	
	
	public String getMappedBy() {
		return mappedBy;
	}

	public void setMappedBy(String mappedBy) {
		this.mappedBy = mappedBy;
	}

	public CascadeType getCascadeType() {
		return cascadeType;
	}

	public void setCascadeType(CascadeType cascadeType) {
		this.cascadeType = cascadeType;
	}

	public FetchType getFetchType() {
		return fetchType;
	}

	public void setFetchType(FetchType fetchType) {
		this.fetchType = fetchType;
	}

	public String getCardinality() {
		return cardinality;
	}

	public void setCardinality(String cardinality) {
		this.cardinality = cardinality;
	}

}
