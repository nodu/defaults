source ./network.sh
source ./git.sh
echo 'basic aliases sourced'

#find strings in folder
alias srch='grep -rniI --exclude-dir={bundles,dist,node_modules,bower_components} . -e' # ex) srch "search term"
srchFilename() {
  find . -iname "*$1*"
}
srchFoldername() {
  find . -iname "*$1*" -type d
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

m.tail-logsf() {
  tail "$(ls -rt /var/log/ -I 'wtmp*' -I '*.gz' -I 'dpkg*gz' -I 'postgresql')" -vf
}

# This handy tool tells you how much space you have left on a drive
alias df='df -h'
#alias du='du -h --max-depth=1'
alias dusort='du -sh * | sort -h'

m.zip-archive() {
  if [ -z "$1" ]; then
    echo "Usage: $0 folder_name"
    return 1
  fi
  # $1 destination archive name
  zip -r "$1.zip" "$1"
}

# Extract
m.zip-unarchive() {
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar xvjf "$1" ;;
    *.tar.gz) tar xvzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xvf "$1" ;;
    *.tbz2) tar xvjf "$1" ;;
    *.tgz) tar xvzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "$1 is not a valid file!"
  fi
}

alias sudo='sudo '

alias sv='sudo nvim'

# Internet speed test function
m.speedtest() {
  speedtest-cli
}

# -a = -rlptgoD; removed -po
# -p, --perms                 preserve permissions
# -o, --owner                 preserve owner (super-user only)
# -n --dry-run
# -del --delete-excluded
# --exclude 'file or dir'
# --info=progress2 try if too verbose also remove -v

alias m.cp-rsync='rsync --recursive --links --times --devices --specials --partial --human-readable --progress -v'
alias m.mv-rsync='rsync --recursive --links --times --devices --specials --partial --human-readable --progress -v --remove-source-files'

m.gpg-import() {
  echo "Provide a private.key for $1"
  gpp --import "$1"
}

m.gpg-encrypt-sign() {
  # Check if either --help is called or not enough arguments are provided
  if [[ "$1" == "--help" || $# -ne 2 ]]; then
    echo "Usage: m.gpg-encrypt-sign <recipient> <file>"
    echo ""
    echo "Encrypt and sign a file for a specified recipient using GPG."
    echo ""
    echo "Arguments:"
    echo "  <recipient>  The GPG key ID, email, or user ID of the recipient"
    echo "  <file>       The file you want to encrypt and sign"
    return 1
  fi

  # Encrypt and sign the file
  gpg --encrypt --sign -r "$1" "$2"
}
m.gpg-encrypt() {
  # Check if either --help is called or if no arguments are provided
  if [[ "$1" == "--help" || $# -ne 1 ]]; then
    echo "Usage: m.gpg-encrypt <file>"
    echo ""
    echo "Encrypt a file symmetrically using GPG."
    echo ""
    echo "Arguments:"
    echo "  <file>   The file you want to encrypt"
    return 1
  fi

  # Encrypt the file symmetrically
  gpg --symmetric "$1"
}
m.gpg-decrypt() {
  # Check if a file was actually passed
  if [[ -z "$1" ]]; then
    echo "Usage: m.gpg-decrypt <file.gpg>"
    return 1
  fi

  # Strip the .gpg extension from the file name if it exists
  output_file="${1%.gpg}"

  # Perform the decryption, specifying the output file
  gpg --output "$output_file" --decrypt "$1"
}

m.base64-decode() {
  echo -n "$1" | base64 -d
}

m.base64-encode() {
  echo -n "$1" | base64
}

ff() {
  m.ff
}

function m.fc() {
  local file
  file=$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
  if [[ $file ]]; then
    cat "$file"
    echo "$file"
  else
    echo "cancelled m.ff"
  fi
}

function m.fd() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
  echo "$dir"
  ls
}

function m.kill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}
function m.env() {
  local out
  out=$(env | fzf)
  echo "$(echo "$out" | cut -d= -f2)"
}
