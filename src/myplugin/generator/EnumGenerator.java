package myplugin.generator;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.swing.JOptionPane;
import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMEnumeration;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;

public class EnumGenerator extends BasicGenerator {

	public EnumGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}

	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			showErrorDialog(e);
		}

		List<FMEnumeration> enums = FMModel.getInstance().getEnumerations();
		for (FMEnumeration e1 : enums) {
			try (Writer out = getWriter(e1.getName(), getFilePackage())) {
				if (out != null) {
					Map<String, Object> context = new HashMap<>();
					context.put("enum", e1);
					getTemplate().process(context, out);
					out.flush();
				}
			} catch (TemplateException | IOException e) {
				showErrorDialog(e);
			}
		}
	}

	@Override
	public Writer getWriter(String fileNamePart, String packageName) throws IOException {
		if (packageName != filePackage) {
			packageName.replace(".", File.separator);
			filePackage = packageName;
		}

		String generatedFileName = "";

		if (templateName.startsWith("enum")) {
			generatedFileName = fileNamePart;
		}

		String fullPath = outputPath + File.separator
				+ (filePackage.isEmpty() ? "" : packageToPath(filePackage) + File.separator)
				+ outputFileName.replace("{0}", generatedFileName);

		File of = new File(fullPath);
		if (!of.getParentFile().exists()) {
			if (!of.getParentFile().mkdirs()) {
				throw new IOException("An error occurred during output folder creation " + outputPath);
			}
		}

		System.out.println(of.getPath());
		System.out.println(of.getName());

		if (!isOverwrite() && of.exists()) {
			return null;
		}

		return new OutputStreamWriter(new FileOutputStream(of));
	}

	public void generateApplicationFile() {
		try {
			super.generate();
		} catch (IOException e) {
			showErrorDialog(e);
		}

		List<FMEnumeration> enums = FMModel.getInstance().getEnumerations();
		try (Writer out = getWriter("Application", getFilePackage())) {
			if (out != null) {
				Map<String, Object> context = new HashMap<>();
				context.put("enum", enums);
				getTemplate().process(context, out);
				out.flush();
			}
		} catch (TemplateException | IOException e) {
			showErrorDialog(e);
		}
	}

	private void showErrorDialog(Exception e) {
		JOptionPane.showMessageDialog(null, e.getMessage());
	}
}
