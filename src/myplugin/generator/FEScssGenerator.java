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

public class FEScssGenerator extends BasicGenerator{

	public FEScssGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}
	public void generate() throws IOException {

		super.generate();

		List<FMClass> classes = FMModel.getInstance().getClasses();

		for (int i = 0; i < classes.size(); i++) {
			FMClass cl = classes.get(i);
			Writer out;
			Map<String, Object> context = new HashMap<String, Object>();
			try {
				out = getWriter(cl.getName(), getFilePackage());
				if (out != null) {
					context.clear();
					context.put("class", cl);
					context.put("referenceProperties", cl.getReferenceProperties());
					context.put("primitiveProperties", cl.getPrimitiveProperties());
					context.put("properties", cl.getProperties());
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

}
