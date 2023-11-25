package myplugin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.swing.JOptionPane;

import myplugin.generator.ControllerGenerator;
import myplugin.generator.EJBGenerator;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;

import com.nomagic.actions.NMAction;
import com.nomagic.magicdraw.actions.ActionsConfiguratorsManager;

/** MagicDraw plugin that performes code generation */
public class MyPlugin extends com.nomagic.magicdraw.plugins.Plugin {

	String pluginDir = null;
	
	private static final String GEN_DIR = "c:/generated";
	private static final String MAIN_JAVA = GEN_DIR + "/src/main/java";
	private static final String PACKAGE_PREFIX = "uns.ac.rs.mbrs";

	public void init() {
		JOptionPane.showMessageDialog(null, "My Plugin init");
		
		// Creating submenu in the MagicDraw main menu
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));

		generateOption("ControllerGenerator", "controller", PACKAGE_PREFIX + ".controller", "{0}Controller.java", MAIN_JAVA);
		generateOption("DataMapperGenerator", "mapper", PACKAGE_PREFIX + ".mapper", "{0}Mapper.java", MAIN_JAVA);
		generateOption("PomGenerator", "pomxml", "", "pom.xml", GEN_DIR);
		generateOption("ServiceGenerator", "service", PACKAGE_PREFIX + ".service", "{0}Service.java", MAIN_JAVA);
		generateOption("RepositoryGenerator", "repository", PACKAGE_PREFIX + ".repository", "{0}Repository.java", MAIN_JAVA);
		
		/**
		 * @Todo: load project options (@see myplugin.generator.options.ProjectOptions)
		 *        from ProjectOptions.xml and take ejb generator options
		 */
		
	}

	private NMAction[] getSubmenuActions() {
		return new NMAction[] { new GenerateAction("Generate"), };
	}

	public boolean close() {
		return true;
	}

	public boolean isSupported() {
		return true;
	}

	private void generateOption(String generatorName, String templateName, String packages, String fileType, String filePath) {
		pluginDir = getDescriptor().getPluginDirectory().getPath();		
		GeneratorOptions option = new GeneratorOptions(filePath, templateName, 
				pluginDir + File.separator + "templates", fileType, true, packages);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put(generatorName, option);
	}

}
