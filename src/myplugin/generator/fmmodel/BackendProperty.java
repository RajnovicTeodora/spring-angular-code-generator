package myplugin.generator.fmmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BackendProperty extends FMProperty {

	public BackendProperty(String name, String type, String visibility,
			int lower, int upper) {
		super(name, type, visibility, lower, upper);
	}

	private boolean jsonIgnore;

}
