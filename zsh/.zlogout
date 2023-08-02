printf "Cleaning up...\n\n"

ssh-add -D

trap 'test -n "$SSH_AGENT_PID" && eval "$(ssh-agent -k)"' 0
print -P "%F{blue}Info: %Bssh-agent%b with PID $SSH_AGENT_PID terminated%f"

print -P "\n%F{cyan}\
 ▄▀▀ ▄▀▄   █   ▄▀▄ █▄ █ ▄▀ 
 ▄██ ▀▄▀   █▄▄ ▀▄▀ █ ▀█ ▀▄█
%f"

print -P "Exiting %B%F{cyan}$(whoami)%f@%F{cyan}$(hostname -s)%f%b in 1 second..."

sleep 1
clear
exit 0
