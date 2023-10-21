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
alias gds='git diff --staged'
alias gdisc='git diff --ignore-space-change'
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
alias glog='git log --oneline --decorate --graph'
alias glgp='git log --stat -p'
alias ggpush='git push origin "$(git_current_branch)"'
alias ggpull='git pull origin "$(git_current_branch)"'

alias m.tail-logs="tail $(ls -rt /var/log/ -I 'wtmp*' -I '*.gz' -I 'dpkg*gz' -I 'postgresql') -vf"

m.tail-logsf() {
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
alias v.='nvim .'
alias sv='sudo nvim'

#Networking
alias m.whatsmyip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias m.whereami-latlong='curl ipinfo.io/loc'
alias m.whereami-country='curl ipinfo.io/country'
alias m.whereami='curl ipinfo.io/json'

# Layer 1: Physical - Is our physical interface up?
alias m.net1-interfaces='ip -br link show'
alias m.net1-interfaces-more='ifconfig'
m.net1-interface-up() {
	#if down:
	ip link set $1 up
}
m.net1-interface-more() {
	#show additional stats like dropped packets
	ip -s link show $1
}

# Layer 2: Data Link 'local Network'
alias m.net2-neighbors='ip neighbor show' # Check ARP Table
m.net2-neighbor-recheck() {
	# args: IP dev interface
	#force new ARP resolution by deleting the record
	ip neighbor delete $1 $2 $3
}

# Layer 3: Network/Internet
alias m.net3-ip-address='ip -br address show' # 1st check local IP address; rules out DHCP or misconfig issues
m.net3-ping() {
	# Start troubleshooting remote host resolution
	ping $1
}
m.net3-traceroute() {
	# Next check the route to the remote host with
	traceroute $1
}

alias m.net3-gateway='ip route show' #check routing table for upstream gateways
m.net3-gateway-check() {
	# check the route for a specific prefix:
	#ip route show 10.0.0.0/8
	ip route show $1
}
m.net3-dns-check() {
	#DNS not L3 protocol
	##nslookup www.google.com
	nslookup $1
}

# Layer 4: Transport - TCP/UDP
#
alias m.net4-httpstat="httpstat"      #check curl connection statistics
alias m.net4-ports-local='ss -tunlp4' #check local listening ports
# -t - Show TCP ports.
# -u - Show UDP ports.
# -n - Do not try to resolve hostnames.
# -l - Show only listening ports.
# -p - Show the processes that are using a particular socket.
# -4 - Show only IPv4 sockets.

alias m.net4-ports-local-process='sudo netstat -tulpn' #show process
m.net4-ports-remote() {
	#$1 ip/host
	sudo nmap -sTU -O $1
}
m.net4-port-connection-tcp() {
	# telnet database.example.com 3306
	# $1 ip/host
	# $2 port
	telnet $1 $2
}

m.net4-port-connection-udp() {
	# Danger, uninstall after using nc
	# nc 192.168.122.1 -u 80
	# $1 ip/host
	# $2 port
	nc $1 -u $2
}
alias m.net-tshark="sudo tshark"
alias m.net-tshark-GET="sudo tshark -Y 'http.request.method == \"GET\"' "
