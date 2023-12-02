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
			CascadeType cascadeType, FetchType fetchType) {
		super(name, type, visibility, lower, upper);
		this.mappedBy = mappedBy;
		this.cascadeType = cascadeType;
		this.fetchType = fetchType;
	}

	private String mappedBy;
	private CascadeType cascadeType;
	private FetchType fetchType;

}
