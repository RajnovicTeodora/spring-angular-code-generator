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

public class FEDeleteTsGenerator extends FETsGenerator{

	public FEDeleteTsGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}
	public void generate() throws IOException {

		super.generate();
		}
}
