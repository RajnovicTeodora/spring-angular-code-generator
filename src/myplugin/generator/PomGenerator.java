package myplugin.generator;

import com.nomagic.magicdraw.core.Application;

import javax.swing.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.options.GeneratorOptions;

public class PomGenerator extends BasicGenerator {

	public PomGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}

	@Override
	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}

		Writer out;
		Map<String, Object> context = new HashMap<String, Object>();
		try {
			out = getWriter("pom", "");
			if (out != null) {
				context.clear();
				context.put("projectName", Application.getInstance().getProject().getName());
				context.put("groupId", "uns.ac.rs.mbrs");
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
