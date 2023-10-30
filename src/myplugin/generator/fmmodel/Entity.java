package myplugin.generator.fmmodel;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Entity extends FMClass{

	public Entity(String name, String classPackage, String visibility) {
		super(name, classPackage, visibility);
	}

	private String tableName;
	
}
