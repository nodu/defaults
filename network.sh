echo 'Loaded: network.sh'

# Detect OS once
_DEFAULTS_OS="$(uname -s)"

#Networking
alias m.whatsmyip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"

# Location information functions
m.whereami_latlong() {
  curl ipinfo.io/loc
}

m.whereami_country() {
  curl ipinfo.io/country
}

m.whereami() {
  curl ipinfo.io/json
}

# Layer 1: Physical - Is our physical interface up?
if [[ "$_DEFAULTS_OS" == "Linux" ]]; then
  alias m.net1-interfaces='ip -br link show'
  alias m.net1-interfaces-more='ifconfig'
  m.net1-interface-up() {
    ip link set "$1" up
  }
  m.net1-interface-more() {
    ip -s link show "$1"
  }
else
  alias m.net1-interfaces='ifconfig -l'
  alias m.net1-interfaces-more='ifconfig -a'
  m.net1-interface-up() {
    sudo ifconfig "$1" up
  }
  m.net1-interface-more() {
    ifconfig "$1"
  }
fi

# Layer 2: Data Link 'local Network'
if [[ "$_DEFAULTS_OS" == "Linux" ]]; then
  alias m.net2-neighbors='ip neighbor show' # Check ARP Table
  m.net2-neighbor-recheck() {
    # args: IP dev interface
    #force new ARP resolution by deleting the record
    ip neighbor delete "$1" "$2" "$3"
  }
else
  alias m.net2-neighbors='arp -a' # Check ARP Table
  m.net2-neighbor-recheck() {
    # args: IP
    #force new ARP resolution by deleting the record
    sudo arp -d "$1"
  }
fi

# Layer 3: Network/Internet
if [[ "$_DEFAULTS_OS" == "Linux" ]]; then
  alias m.net3-ip-address='ip -br address show' # 1st check local IP address; rules out DHCP or misconfig issues
  alias m.net3-gateway='ip route show'          #check routing table for upstream gateways
  m.net3-gateway-check() {
    # check the route for a specific prefix:
    #ip route show 10.0.0.0/8
    ip route show "$1"
  }
else
  alias m.net3-ip-address='ifconfig | grep "inet "' # 1st check local IP address; rules out DHCP or misconfig issues
  alias m.net3-gateway='netstat -rn'                #check routing table for upstream gateways
  m.net3-gateway-check() {
    # check the route for a specific destination:
    route get "$1"
  }
fi

m.net3-ping() {
  # Start troubleshooting remote host resolution
  ping "$1"
}
m.net3-traceroute() {
  # Next check the route to the remote host with
  traceroute "$1"
}
m.net3-dns-check() {
  #DNS not L3 protocol
  ##nslookup www.google.com
  nslookup "$1"
}

# Layer 4: Transport - TCP/UDP
#
alias m.net4-httpstat="httpstat" #check curl connection statistics

if [[ "$_DEFAULTS_OS" == "Linux" ]]; then
  alias m.net4-ports-local='ss -tunlp4' #check local listening ports
  # -t - Show TCP ports.
  # -u - Show UDP ports.
  # -n - Do not try to resolve hostnames.
  # -l - Show only listening ports.
  # -p - Show the processes that are using a particular socket.
  # -4 - Show only IPv4 sockets.
  alias m.net4-ports-local-process='sudo netstat -tulpn' #show process
else
  alias m.net4-ports-local='lsof -iTCP -sTCP:LISTEN -P -n'              #check local listening ports
  alias m.net4-ports-local-process='sudo lsof -iTCP -sTCP:LISTEN -P -n' #show process with sudo
fi

m.net4-ports-remote() {
  if [ -z "$1" ]; then
    echo "Usage: $0 <ip/host>"
    return 1
  fi

  sudo nmap -sTU -O "$1"
}

m.net4-port-connection-tcp() {
  # telnet database.example.com 3306
  #  "$1" ip/host
  #  "$2" port
  telnet "$1" "$2"
}

m.net4-port-connection-udp() {
  # Danger, uninstall after using nc
  # nc 192.168.122.1 -u 80
  #  "$1" ip/host
  #  "$2" port
  nc "$1" -u "$2"
}
alias m.net-tshark="sudo tshark"
alias m.net-tshark-GET="sudo tshark -Y 'http.request.method == \"GET\"' "
