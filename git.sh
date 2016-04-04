# Aliases related to git stuff

alias -g commti='commit'
alias -g gti='git'
alias g='git'

alias -g gc='git commit'
alias -g gca='git commit -a'

alias -g gs='git status -sb'
alias -g gb='git branch -v'

alias -g gps='git push'
alias -g gpl='git pull'

alias -g gsss='git stash'
alias -g gspp='git stash pop'
alias -g gsll='git stash list'

alias -g gd='git diff --color --color-words'
alias -g gdc='gd --cached'

alias -g gck='git checkout'
alias -g gsum='git summary'

alias -g gll='git log --color --no-merges --graph --pretty=format:"%C(auto)%h %C(auto)%d%Creset %C(auto)%s %C(red)%m%m %C(cyan)%an" --color --graph'
alias -g gl='git --no-pager log -30 --color --no-merges --graph --pretty=format:"%C(auto)%h %C(auto)%d%Creset %C(auto)%s %C(red)%m%m %C(cyan)%an" --color --graph'
alias -g grp='git \grep --break --heading --color -B 1 -A 2 -n -I'

function ggrep() {

    case $1 in
        'js' | 'javascript')
            lang='javascript'
            ;;
        'c' | 'c++' | 'cpp')
            lang=c++
            ;;
        'ruby' | 'rb')
            lang=ruby
            ;;
        'py' | 'python')
            lang=python
            ;;
        'sh' | 'bash' | 'zsh')
            lang=bash
            ;;
        'ocaml')
            lang=ocaml
            ;;
    esac

    if [ -z $lang ]; then
        langOpt='-g'
    else
        langOpt="-l$lang"
        shift
    fi

    pattern=$1
    shift
    g \grep -B 1 -A 3 --break --heading --show-function --no-color -n -I -e $pattern -- $* | pygmentize $langOpt -O bg=dark,fg=light,full -f256 | \less -r
}

alias -g grpjs='ggrep \js'


# vim: ft=zsh
alias -g ga='git add'

# Full synchronisation
alias  gsync='gpl && gps'
alias  gcm="git commit -m '"

# Add diff chunks by chunks
alias -g gap='git add -p'
alias  gmv='g mv'
alias  gf='g fetch origin'
alias  gam='gc --amend'
alias  gpf='gps --force'

alias -g gbcur='git branch | grep "^*" | grep -Po "[\w-.]+$"'
# porcelain version
alias -g gbcur_p='echo refs/heads/$(gbcur)'

alias -g gpss='git push origin $(gbcur_p)'
alias -g gpssu='git push origin -u $(gbcur_p)'
alias -g gprelease='gpssu && git tag -f $(gbcur) && gps origin $(gbcur_p) --tags'

# reove merged branches
alias  g_rm_merged="git branch --merged | grep -v '^\*' | grep -v -P '(demo)|(release)' | xargs -n 1 git branch -d"
alias  gpsf='git push origin $(gbcur) --force'
alias  gmm='gck master && gpl && gck - && g merge master'
alias gch='g reset --hard && gck'
alias grh='g reset --hard'
alias gsr='gb | gi'
function gmk() {
    branch=$1
    force=$2
    [ -z $branch ] && {
        echo "Need a branch as argument"
        return 1
    }
    [[ $force == '-f' ]] && g reset --hard
    gck $branch && gpl && gck - && g merge $branch
}
alias gback='gb | gi behind'
alias  gpll='git pull origin master'
