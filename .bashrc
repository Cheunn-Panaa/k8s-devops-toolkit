export HISTTIMEFORMAT="%d/%m/%y %T "
export PS1='\u@\h:\W \$ '
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:${HOME}/.kube/bin:$PATH"

source /etc/profile.d/bash_completion.sh
source /etc/profile.d/kubectl
source /etc/profile.d/kubens
source /etc/profile.d/kubectx

alias k="kubectl"
alias kc="kubectl"
alias kx="kubectx"
alias kn="kubens"
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

complete -F __start_kubectl k
complete -F __start_kubectl kc
complete -F _kube_namespaces kn
complete -F _kube_contexts kx