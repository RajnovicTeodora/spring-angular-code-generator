package myplugin.generator;

import java.io.IOException;

import myplugin.generator.options.GeneratorOptions;

public class FEEditHtmlGenerator extends FEGeneratorHTML{

	public FEEditHtmlGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}
		public void generate() {

		try {
			super.generate();
		} catch (IOException e) {
			e.printStackTrace();
		}}

}