To compile and run these examples, you need the following:

Java 6 compiler on your machine and in your PATH environment
Apache ant

The build file uses ivy to download dependencies.  If you don't have ivy installed, ant can do it for you, automatically.  If you don't know if you have ivy installed, just run the following command:

ant install.ivy

This should download ivy and install it on your local machine, so the build script has access to it.  The general build is started by running this command:

ant build

This should produce the library "java-examples.jar" in your lib folder.

To run the examples, use the script in the bin folder, which correctly adds jars in your lib folder to the classpath (hint: if you want to enable logging of all messages to stdio, please set -DWORDNIK_DEBUG in the bin/run.sh):

./bin/run.sh com.wordnik.examples.WordDataExample {api_key} {word}

For the word data demo:
Replace {api_key} with your api key, and {word} with the wordstring you want to pass to the api.

For the Word of the Day demo:
./bin/run.sh com.wordnik.examples.WordOfTheDayDemo {api_key}

The Word List Demo requires authentication.  It will create a list named {list_name} with the words {words}.  For
words, you can comma-separate words as such: "great, neat, good fun, fantastic"
For the Word List Demo:
./bin/run.sh com.wordnik.examples.WordListExample {api_key} {user_name} {password} {list_name} {words}

If you have any questions, please see the following resources:

Our Google Group:
http://groups.google.com/group/wordnik-api/ 

Our docs page:
http://docs.wordnik.com/api

Old-fashioned Email:
apiteam@wordnik.com.
