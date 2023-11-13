package myplugin;

import java.awt.event.ActionEvent;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import com.nomagic.magicdraw.actions.MDAction;
import com.nomagic.magicdraw.core.Application;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import myplugin.analyzer.AnalyzeException;
import myplugin.analyzer.ModelAnalyzer;
import myplugin.generator.BasicGenerator;
import myplugin.generator.ControllerGenerator;
import myplugin.generator.EJBGenerator;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;

/** Action that activate code generation */
@SuppressWarnings("serial")
class GenerateAction extends MDAction {

	private static final String PACKAGE_PREFIX = "uns.ac.rs.mbrs";

	public GenerateAction(String name) {
		super("", name, null, null);
	}

	public void actionPerformed(ActionEvent evt) {

		if (Application.getInstance().getProject() == null)
			return;
		Package root = Application.getInstance().getProject().getModel();

		if (root == null)
			return;

		ModelAnalyzer analyzer = new ModelAnalyzer(root, "ejb");

		try {
			analyzer.prepareModel();

			this.generateComponent(root, PACKAGE_PREFIX + ".controller", "ControllerGenerator");
			this.generateComponent(root, PACKAGE_PREFIX + ".datamapper", "DataMapperGenerator");

			// this.generateComponent(root, PACKAGE_PREFIX + ".service",
			// "ServiceGenerator");

			/** @ToDo: Also call other generators */

			// TODO folder name
			JOptionPane.showMessageDialog(null,
					"Code is successfully generated! Generated code is in folder: SOME_FOLDER");
//			+ go.getOutputPath() + ", package: " + go.getFilePackage());
			exportToXml();
		} catch (AnalyzeException | IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
	}

	private void exportToXml() {
		if (JOptionPane.showConfirmDialog(null, "Do you want to save FM Model?") == JOptionPane.OK_OPTION) {
			JFileChooser jfc = new JFileChooser();
			if (jfc.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
				String fileName = jfc.getSelectedFile().getAbsolutePath();

				XStream xstream = new XStream(new DomDriver());
				BufferedWriter out;
				try {
					out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileName), "UTF8"));
					xstream.toXML(FMModel.getInstance().getClasses(), out);
					xstream.toXML(FMModel.getInstance().getEnumerations(), out);

				} catch (UnsupportedEncodingException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());
				} catch (FileNotFoundException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());
				}
			}
		}
	}

	private void generateComponent(Package root, String packageName, String generatorName)
			throws AnalyzeException, IOException {
		ModelAnalyzer analyzer = new ModelAnalyzer(root, packageName);
		analyzer.prepareModel();
		GeneratorOptions generatorOptions = ProjectOptions.getProjectOptions().getGeneratorOptions().get(generatorName);
		BasicGenerator generator;

		switch (generatorName) {
			case "EJBGenerator":
				generator = new EJBGenerator(generatorOptions);
				break;
			case "ControllerGenerator":
				generator = new ControllerGenerator(generatorOptions);
				break;
			// TODO... Add other generators

			default:
				throw new IllegalArgumentException("Unknown generator " + generatorName);
		}

		generator.generate();
	}

}