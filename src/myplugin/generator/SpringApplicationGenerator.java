package myplugin.generator;

import myplugin.generator.options.GeneratorOptions;

import com.nomagic.magicdraw.core.Application;
import freemarker.template.TemplateException;

import javax.swing.*;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

public class SpringApplicationGenerator extends BasicGenerator {

	private final String PACKAGE_NAME = "uns.ac.rs.mbrs";

	public SpringApplicationGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}

	public void generate() {
		try {
			super.generate();
			generateSpringApplication();
		} catch (IOException | TemplateException e) {
			showErrorDialog(e.getMessage());
		}
	}

	private void generateSpringApplication() throws IOException, TemplateException {
		Map<String, Object> context = createContext();
		Writer out = getWriterForProject();
		if (out != null) {
			getTemplate().process(context, out);
			out.flush();
		}
	}

	private Map<String, Object> createContext() {
		Map<String, Object> context = new HashMap<>();
		context.put("package", PACKAGE_NAME);
		return context;
	}

	private Writer getWriterForProject() throws IOException {
		return getWriter(Application.getInstance().getProject().getName(), PACKAGE_NAME);
	}

	private void showErrorDialog(String message) {
		JOptionPane.showMessageDialog(null, message);
	}
}
