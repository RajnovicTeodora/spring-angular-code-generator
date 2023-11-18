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

	public FMPrimitiveProperty(String name, String type, String visibility,
			int lower, int upper) {
		super(name, type, visibility, lower, upper);

	}

	private String columnName;
	private GenerationType generationType;
	private int lenght;
	private Boolean isId;
	private Boolean unique;
}
