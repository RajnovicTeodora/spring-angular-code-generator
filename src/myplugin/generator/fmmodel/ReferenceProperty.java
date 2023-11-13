package myplugin.generator.fmmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReferenceProperty extends BackendProperty {

	public ReferenceProperty(String name, String type, String visibility,
			int lower, int upper) {
		super(name, type, visibility, lower, upper);
	}

	private String mappedBy;
	private CascadeType cascadeType;
	private FetchType fetchType;

}
