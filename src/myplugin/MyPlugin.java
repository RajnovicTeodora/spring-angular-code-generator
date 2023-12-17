package myplugin;

import java.io.File;

import javax.swing.JOptionPane;

import com.nomagic.actions.NMAction;
import com.nomagic.magicdraw.actions.ActionsConfiguratorsManager;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;

/** MagicDraw plugin that performes code generation */
public class MyPlugin extends com.nomagic.magicdraw.plugins.Plugin {

	String pluginDir = null;

	private static final String GEN_DIR = "c:/generated";
	private static final String MAIN_JAVA = GEN_DIR + "/backend/src/main/java";
	private static final String FRONTED_APP = GEN_DIR + "/frontend";
	private static final String PACKAGE_PREFIX = "uns.ac.rs.mbrs";
	private static final String APP_DIR = "src.app";
	
	public void init() {
		JOptionPane.showMessageDialog(null, "My Plugin init");

		// Creating submenu in the MagicDraw main menu
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));

		generateOption("ControllerGenerator", "controller", PACKAGE_PREFIX + ".controller", "{0}Controller.java", MAIN_JAVA);
		generateOption("DataMapperGenerator", "mapper", PACKAGE_PREFIX + ".mapper", "{0}Mapper.java", MAIN_JAVA);
		generateOption("EnumGenerator", "enum", PACKAGE_PREFIX + ".enum", "{0}.java", MAIN_JAVA);
		generateOption("PomGenerator", "pomxml", "", "pom.xml", GEN_DIR);
		generateOption("ServiceGenerator", "service", PACKAGE_PREFIX + ".service", "{0}Service.java", MAIN_JAVA);
		generateOption("RepositoryGenerator", "repository", PACKAGE_PREFIX + ".repository", "{0}Repository.java", MAIN_JAVA);
		generateOption("SpringApplicationGenerator", "springapplication", PACKAGE_PREFIX, "SpringApplication.java", MAIN_JAVA);
		
		//FrontEnd Application  
		generateOption("FEModelGenerator", "model", APP_DIR + ".shared.model", "{0}.ts", FRONTED_APP);
		generateOption("FEGeneratorDeleteHTML", "frontend/delete-item-html", APP_DIR, "{0}/{0}-delete/{0}-delete.component.html", FRONTED_APP);
		generateOption("FEGeneratorDeleteSCSS", "frontend/delete-item-scss", APP_DIR, "{0}/{0}-delete/{0}-delete.component.scss", FRONTED_APP);
		generateOption("FEGeneratorDeleteTS", "frontend/delete-item-ts", APP_DIR, "{0}/{0}-delete/{0}-delete.component.ts", FRONTED_APP);
		
		generateOption("FEGeneratorViewHTML", "frontend/view-item-html", APP_DIR, "{0}/{0}-view/{0}-view.component.html", FRONTED_APP);
		generateOption("FEGeneratorViewSCSS", "frontend/view-item-scss", APP_DIR, "{0}/{0}-view/{0}-view.component.scss", FRONTED_APP);
		generateOption("FEGeneratorViewTS", "frontend/view-item-ts", APP_DIR, "{0}/{0}-view/{0}-view.component.ts", FRONTED_APP);

		generateOption("FEGeneratorEditHTML", "frontend/edit-item-html", APP_DIR, "{0}/{0}-edit/{0}-edit.component.html", FRONTED_APP);
		generateOption("FEGeneratorEditSCSS", "frontend/edit-item-scss", APP_DIR, "{0}/{0}-edit/{0}-edit.component.scss", FRONTED_APP);
		//generateOption("FEGeneratorEditTS", "frontend/edit-item-ts", APP_DIR, "{0}/{0}-edit/{0}-edit.component.ts", FRONTED_APP);

		generateOption("FERoutingGenerator", "app.routes", APP_DIR, "app.routes.ts", FRONTED_APP);
		generateOption("FETsGenerator", "frontend/model-route", APP_DIR, "{0}/{0}.routes.ts", FRONTED_APP);
		generateOption("FEServiceGenerator", "frontend/feservice", APP_DIR + ".shared.service", "{0}/{0}.service.ts", FRONTED_APP);
		generateOption("FELayoutComponentGenerator", "frontend/layout-ts", APP_DIR + ".layout", "layout.component.ts", FRONTED_APP);
		generateOption("FELayoutHtmlGenerator", "frontend/layout-html", APP_DIR + ".layout", "layout.component.html", FRONTED_APP);
		
		generateOption("FEItemsHtmlGenerator", "frontend/items/items-html", APP_DIR, "{0}/{0}s/{0}s.component.html", FRONTED_APP);
		generateOption("FEItemsScssGenerator", "frontend/items/items-scss", APP_DIR, "{0}/{0}s/{0}s.component.scss", FRONTED_APP);
		generateOption("FEItemsTsGenerator", "frontend/items/items-ts", APP_DIR, "{0}/{0}s/{0}s.component.ts", FRONTED_APP);
		//generateOption("FEItemsSpecTsGenerator", "frontend/items/items-spec-ts", APP_DIR, "{0}/{0}s/{0}s.component.spec.ts", FRONTED_APP);
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

	private void generateOption(String generatorName, String templateName, String packages, String fileType,
			String filePath) {
		pluginDir = getDescriptor().getPluginDirectory().getPath();
		GeneratorOptions option = new GeneratorOptions(filePath, templateName, pluginDir + File.separator + "templates",
				fileType, true, packages);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put(generatorName, option);
	}

}
