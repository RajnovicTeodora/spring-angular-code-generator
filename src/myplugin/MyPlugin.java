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

	private static final String BACKEND_FILEPATH = "src//main//java//uns//ac//rs//mbrs//";

	public void init() {
		JOptionPane.showMessageDialog(null, "My Plugin init");
		
		pluginDir = getDescriptor().getPluginDirectory().getPath();

		// Creating submenu in the MagicDraw main menu
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));

		// generateOption("ControllerGenerator", "controller", BACKEND_FILEPATH + "controllers", "{0}.java");
        // generateOption("ServiceGenerator", "service", BACKEND_FILEPATH + "services", "{0}.java");
	    generateOption("RepositoryGenerator", "repository", BACKEND_FILEPATH + "repositorys", "{0}.java");
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

	private void generateOption(String generatorName, String templateName, String filePath, String fileType) {
		pluginDir = getDescriptor().getPluginDirectory().getPath();
		String output_path = getOutputPath();
		GeneratorOptions option = new GeneratorOptions(output_path, templateName, "templates", fileType, true,
				filePath);
		option.setTemplateDir(pluginDir + File.separator + option.getTemplateDir());
		ProjectOptions.getProjectOptions().getGeneratorOptions().put(generatorName, option);
	}

	private String getOutputPath() {
		String output_path = "";
		Properties prop = new Properties();
		InputStream input = null;
		try {
			input = new FileInputStream("resources/ProjectOptions.xml");
			// load a properties file
			prop.load(input);
			// get the property value and print it out
			output_path = prop.getProperty("OUTPUT_PATH");
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return output_path;
	}

}
