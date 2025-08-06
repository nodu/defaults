echo 'Loaded: git.sh'

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

m.git-quickcommit() {
  git status
  git diff
  git commit -m "Update"
  git push
}

m.git-quickcommit-all() {
  git status
  git diff
  #pause()
  #read -p 'Press any key to continue...'
  git add -A :/
  git commit -m "Update"
  git push
}

m.git-rebase-continue() {
  git rebase --continue
}

m.git-stardate() {
  echo "./stardate.sh \"last monday 8:07:23pm\" \"init\" "

  stardate=$(date -d "$1" +"%a %b %d %T %Y %z")

  GIT_COMMITTER_DATE="$stardate" git commit --date "$stardate" -m "$2"

  # GIT_COMMITTER_DATE="date-here" git commit --amend --no-edit --date "date-here"
}

function m.git-uncommit-last() {
  git reset --soft HEAD~1
}

function m.git-unstage-file() {
  git reset HEAD
}

function m.git-restore-staged() {
  git restore --staged "$1"
}
alias m.grs=m.git-restore-staged

function m.git-show() {
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" |
    fzf --ansi --no-sort --reverse --tiebreak=index --preview \
      'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
      --bind "ctrl-d:preview-page-down,ctrl-u:preview-page-up,enter:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF" --preview-window=right:60%
}

alias m.gs=m.git-show

check_git_status() {
  local start_dir="$1"

  # Check if the provided directory exists
  if [ ! -d "$start_dir" ]; then
    echo "The directory $start_dir does not exist."
    return 1
  fi

  find "$start_dir" -type d -name '.git' | while read dir; do
    sh -c "cd '$dir'/../ && git_status=\$(git status -s); if [ ! -z \"\$git_status\" ]; then echo -e \"\nGIT STATUS IN ${dir//\.git/}\"; echo \"\$git_status\"; fi"
  done
}
