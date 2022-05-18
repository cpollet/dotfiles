export HISTFILE=$ZSH/history
export HISTSIZE=10000
export SAVEHIST=10000

# see man zshoptions for all options

# where possible, the history entry is written out to the file after the
# command is finished, so that the time taken  by  the  command  is
# recorded correctly in the history file
setopt inc_append_history_time

# save each command's beginning timestamp (in seconds since the epoch) and
# the duration (in seconds) to the history file.
setopt extended_history

# if a new command line being added to the history list duplicates an
# older one, the older command is removed from the list
setopt hist_ignore_all_dups

# remove  command  lines  from  the history list when the first character
# on the line is a space, or when one of the expanded aliases contains a
# leading space.
setopt hist_ignore_space

# Whenever the user enters a line with history expansion, don't execute
# the line directly; instead, perform history expansion and reload the
# line into the editing buffer.
setopt hist_verify

alias history='fc -El 1'