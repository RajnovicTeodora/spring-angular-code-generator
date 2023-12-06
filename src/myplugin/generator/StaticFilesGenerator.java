package myplugin.generator;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.function.Consumer;
import java.util.function.Predicate;

public class StaticFilesGenerator {

	public static void copy(String sourcePath, String destinationPath) throws IOException {

		try {
			// Get the file from the resources/static folder
			final Path sourceDirectory = Paths.get(sourcePath);
			final Path destinationDirectory = Paths.get(destinationPath);

			// List all files in the source directory
			Files.walk(sourceDirectory).filter(new Predicate<Path>() {
				@Override
				public boolean test(Path path) {
					return Files.isRegularFile(path);
				}
			}).forEach(new Consumer<Path>() {
				@Override
				public void accept(Path sourceFile) {
					try {
						// Define the destination path for each file in the destination directory
						Path destinationFile = destinationDirectory.resolve(sourceDirectory.relativize(sourceFile));

						// Create directories if they don't exist in the destination path
						Files.createDirectories(destinationFile.getParent());

						// Copy the file from source to destination
						Files.copy(sourceFile, destinationFile);

						System.out.println("File copied: " + sourceFile.getFileName());
					} catch (IOException e) {
						System.err.println("Failed to copy file: " + e.getMessage());
					}
				}
			});

			System.out.println("All files copied successfully!");
		} catch (IOException e) {
			System.err.println("Error occurred: " + e.getMessage());
		}
	}
}
