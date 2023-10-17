echo 'basic aliases sourced'

#find strings in folder
alias srch='grep -rniI --exclude-dir={bundles,dist,node_modules,bower_components} . -e' # ex) srch "search term"
srchFilename() {
	find . -iname "*$1*"
}

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias back='cd $OLDPWD'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ll='ls -al'
alias l='ls -alrt'

alias g='git'
alias ga='git add'
alias gaa='git add -A :/'
alias gai='git add -i'

alias gd='git diff --color'
alias gpom='git pull origin master'
alias gpum='git push origin master'
alias gc='git commit -v -m'
alias gst='git status'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gcop='git checkout -p'
alias gcp="git cherry-pick"

alias gs='git stash'
alias gsa='git stash apply'
alias gcheckpoint='git stash && git stash apply'

alias gl='git prettylog'
glog='git log --oneline --decorate --graph'
glgp='git log --stat -p'

alias ggpush='git push origin "$(git_current_branch)"'
alias ggpull='git pull origin "$(git_current_branch)"'

alias mn-tail-logs="tail $(ls -rt /var/log/ -I 'wtmp*' -I '*.gz' -I 'dpkg*gz' -I 'postgresql') -vf"

mn-tail-logsf() {
	tail $(ls -rt /var/log/ -I 'wtmp*' -I '*.gz' -I 'dpkg*gz' -I 'postgresql') -vf
}

# This handy tool tells you how much space you have left on a drive
alias df='df -h'
#alias du='du -h --max-depth=1'
alias dusort='du -sh * | sort -h'

archive() {
	# $1 destination archive name
	# $2 archive folder
	zip -r $1 $2
}

# Extract
unarchive() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xvjf $1 ;;
		*.tar.gz) tar xvzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xvf $1 ;;
		*.tbz2) tar xvjf $1 ;;
		*.tgz) tar xvzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

alias sudo='sudo '

alias v='nvim'
alias V='nvim .'
alias sv='sudo nvim'

#Networking
alias mn-whatsmyip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias mn-whereami-latlong='curl ipinfo.io/loc'
alias mn-whereami-country='curl ipinfo.io/country'
alias mn-whereami='curl ipinfo.io/json'

alias mn-portcheck-local='sudo netstat -tulpn | grep LISTEN'
alias mn-portcheck-remote='sudo sudo nmap -sTU -O'

# telnet 192.168.8.6
# ip -br address show
# ip show
# ifconfig
# ip link show

alias d='docker'
alias dc='docker-compose'
alias dcr='docker-compose restart'
