alias d='docker'
alias dps='docker ps -a --format "table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}"'
alias dw='wt eval "dps | grep -v dnsdock | grep -v NAME | sort"'
alias dkill='for c in $(docker ps -a --format "table {{.Names}}" | grep -v NAMES | grep -v dnsdock); do docker kill $c; done'
alias dv='docker volume'
alias dn='docker network'

alias dstop='docker ps -a -q | xargs docker stop >/dev/null ; docker start dnsdock >/dev/null'
alias dclean='docker ps -a -q | xargs docker rm >/dev/null 2>&1'
alias dsc='dstop;dclean;dps'

alias docker_run='docker run -it --rm -v `pwd`:/host '
#alias docker_prune='docker system prune --volumes'

function docker_clean {
	stopped_containers=`docker ps -q -f "status=exited"`
	if [[ $stopped_containers != '' ]]; then
		echo  Destroying $stopped_containers
		docker rm $stopped_containers
	fi

	dangling_images=`docker images -q -f "dangling=true"`
	if [[ $dangling_images != '' ]]; then
		echo Deleting `docker images -q -f "dangling=true"`
		docker rmi `docker images -q -f "dangling=true"`
	fi

	for i in `docker images --format "{{.Repository}}:{{.Tag}}" | grep SNAP`; do
		echo "Deleting snapshot image $i"
		docker rmi $i
	done

	for i in `docker images --format "{{.Repository}}:{{.Tag}}#{{.CreatedSince}}" | grep -E 'years ago|[0-9]{2} months ago' | sed -E 's/#.*//'`; do
		echo "Deleting >9 months old image $i"
		docker rmi $i
	done

	for i in `docker images --format "{{.Repository}}:{{.Tag}}" | grep '<none>'`; do
		echo "Deleting '<none> image $i"
		docker rmi $i
	done

	docker system prune --volumes
}

function docker_run() {
  # ref: https://github.com/rawkode/zsh-docker-run
  docker run --rm -it -u $UID -v $PWD:/sandbox -v $HOME:$HOME -e HOME=$HOME -w /sandbox --entrypoint=$2 $1 ${@:3}
}

alias ubuntu='docker_run "ubuntu:latest" "/bin/bash"'