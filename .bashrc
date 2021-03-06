# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [[ -n "$PS1" ]]; then # disable "&& return" for rvm

  # don't put duplicate lines in the history. See bash(1) for more options
  # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
  export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
  # ... or force ignoredups and ignorespace
  export HISTCONTROL=ignoreboth
  
  # append to the history file, don't overwrite it
  shopt -s histappend
  
  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
  
  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize
  
  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
  
  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi
  
  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  force_color_prompt=yes
  
  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
  fi

  # Load in the git branch prompt script.
  source ~/.git-prompt.sh

  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1) \$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt
  
  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
    xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
    *)
    ;;
  esac

  # load git completions
  source ~/.git-completion.sh


  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
  fi


  # Disable the Caps Lock key (doesn't work on osx)
  #instaxmodmap -e "remove lock = Caps_Lock"
  
  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi


  # Alias definitions.
  if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi

  # Env Variables
  if [ -f ~/.bash_env ]; then
    . ~/.bash_env
  fi

  # Maven Color
  if [ -f ~/.bash_mvn-color ]; then
    . ~/.bash_mvn-color
  fi

  # Maven Completion
  if [ -f ~/.bash_maven_completion ]; then
    . ~/.bash_maven_completion
  fi

fi
#RVM Ruby version management MUST BE LAST LINE
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
#if [[ -s "$HOME/.rvm/scripts/rvm" ]]
#  then source "$HOME/.rvm/scripts/rvm"
#fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
nvm use default 2&>/dev/null

#pyenv
eval "$(pyenv init -)"
