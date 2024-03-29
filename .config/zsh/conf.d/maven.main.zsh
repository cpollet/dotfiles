command -v mvn &>/dev/null || return 0

export MAVEN_OPTS=-Djava.awt.headless=true

alias m='mvn'
alias mvnci='mvn clean install'
alias mci='mvn clean install'
alias mvncist='mvn clean install -DskipTests'
alias mvncv='mvn clean verify -Ddockerfile.skip=true -Dskip.pmd=true -Dcheckstyle.skip=true -Dspotbugs.skip=true'
alias mcist='mvn clean install -DskipTests'
alias mvnd='mvn clean deploy'
alias mvndst='mvn clean deploy -DskipTests'
alias mvntg='mvn dependency:tree | less | grep '
alias mvnsrc='mvn dependency:sources'
alias mvncd='mvn clean dependency:copy-dependencies'
alias mvnep='mvn help:effective-pom | less'
alias mvnvs='mvn versions:set'
alias mvns='mvn dependency:tree | grep -E "\[INFO\] [+|]" | grep SNAPSHOT'
alias mvnf='mvn -f'

alias -g Dst='-DskipTests'

function mvnt() {
	mvn $@ dependency:tree | $PAGER
}
