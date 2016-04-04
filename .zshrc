HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

PROMPT=$'%{\e[01;32m%}%~ %{\e[01;34m%}$%{\e[0m%} '
RPROMPT=$'%{\e[0;33m%}%D{%a %b %e, %H:%M:%S}%{\e[0m%}'

bindkey -v

alias ls='ls --color=auto'
alias ll='ls -al'
alias grep='grep --colour=auto'
alias service='systemctl'
alias irc='mosh srcf -- tmux attach-session -t irssi'
alias sup='mosh srcf -- vim public_html/self/supervisions.html'
alias matlab='ssh ds -Y -t matlab'
alias mount='sudo mount'
alias umount='sudo umount'
alias :q='exit'

echo -en "\e]P0000000" # Black
echo -en "\e]P1CC0000" # Red
echo -en "\e]P24E9A06" # Green
echo -en "\e]P3C4A000" # Yellow
echo -en "\e]P43465A4" # Blue
echo -en "\e]P575507B" # Magenta
echo -en "\e]P606989A" # Cyan
echo -en "\e]P7DED7CF" # White
echo -en "\e]P8555753" # Bright Black
echo -en "\e]P9EF2929" # Bright Red
echo -en "\e]PA8AE234" # Bright Green
echo -en "\e]PBFCE94F" # Bright Yellow
echo -en "\e]PC729FCF" # Bright Blue
echo -en "\e]PDAD7FA8" # Bright Magenta
echo -en "\e]PE34E2E2" # Bright Cyan
echo -en "\e]PFEEEEEC" # Bright White

clear

if [ "$TERM" '==' "linux" ]; then
    if [ "$TMUX" '==' "" ]; then
        tmux -2
    fi
fi

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

autoload -U compinit
compinit

#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus
