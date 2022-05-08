function j() {
  echo "Switching to java $1"
  if [ -f /usr/libexec/java_home ]; then
    export JAVA_HOME=`/usr/libexec/java_home $1`
  elif [ -d /softwares/java-$1 ]; then
    export JAVA_HOME=/softwares/java-$1
  else
    echo "Cannot switch to java $1"
    return
  fi

  echo "JAVA_HOME=$JAVA_HOME"
  echo
  echo "Java executable"
  java -version 3>&1 | grep --color=always ".*version.*\|$" | while read line ; do echo "    $line"; done
  echo
  echo "Maven configuration"
  mvn -v | grep --color=always "Java version.*\|$" | grep --color=always "Apache Maven.*\|$" | while read line ; do echo "    $line"; done
}

alias j8='j 8'
alias j11='j 11'
