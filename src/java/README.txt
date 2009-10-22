To compile and run these examples, you need the following:

Java 6 compiler on your machine and in your PATH environment
Apache ant

The build file uses ivy to download dependencies.  If you don't have ivy installed, ant can do it for you, automatically.  If you don't know if you have ivy installed, just run the following command:

ant install.ivy

This should download ivy and install it on your local machine, so the build script has access to it.  The general build is started by running this command:

ant build

This should produce the library "java-examples.jar" in your lib folder.

To run the examples, use the script in the bin folder, which correctly adds jars in your lib folder to the classpath:

./bin/runclass.sh com.wordnik.examples.WordDataExample {api_key} {word}

Replace {api_key} with your api key, and {word} with the wordstring you want to pass to the api.

If you have any questions, please see our blog at http://docs.wordnik.com/api, or email us at apiteam@wordnik.com.
