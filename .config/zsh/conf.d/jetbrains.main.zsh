alias e='idea -e'
alias killIdea='kill -9 $(ps aux | grep idea | awk "{print $2}" | tr "\n" " ")'