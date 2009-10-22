#!/bin/bash
echo "" > classpath.txt
for file in `ls lib`;
        do echo -n 'lib/' >> classpath.txt;
        echo -n $file >> classpath.txt;
        echo -n ':' >> classpath.txt;
done
export CLASSPATH=$(cat classpath.txt)
export JAVA_OPTS="-Duser.timezone=GMT ${JAVA_CONFIG_OPTIONS} ${JAVA_DEBUG_OPTIONS} "

java $JAVA_OPTS -cp $CLASSPATH $1 $2 $3 $4 $5 $6 $7 $8 $9
