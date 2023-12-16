package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;

public class FELayoutHtmlGenerator extends BasicGenerator {

	public FELayoutHtmlGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}

	@Override
	public void generate() {
		try {
			super.generate();
		} catch (IOException e1) {

			e1.printStackTrace();
		}
		List<FMClass> classes = FMModel.getInstance().getClasses();

		Writer out;
		Map<String, Object> context = new HashMap<String, Object>();
		try {
			out = getWriter("Application", getFilePackage());
			if (out != null) {
				context.clear();
				context.put("classes", classes);
				getTemplate().process(context, out);
				out.flush();
			}
		} catch (TemplateException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
	}

}
