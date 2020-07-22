export HISTTIMEFORMAT="%d/%m/%y %T "
export PS1='\u@\h \W $(kube_ps1)\$ '
export PATH="${HOME}/.kube/bin:$PATH"

source /etc/profile.d/bash_completion.sh
source /google-cloud-sdk/path.bash.inc
source /google-cloud-sdk/completion.bash.inc
source /usr/local/bin/ps1 
source /etc/profile.d/kubectl
source /etc/profile.d/kubens
source /etc/profile.d/kubectx

alias profile='echo ${PROFILE}'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

alias k="kubectl"
alias kc="kubectl"
alias kx="kubectx"
alias kn="kubens"

alias kp="kubeon"
alias nokp="kubeoff"

alias ke="k exec -it"
alias logs='k logs'
alias ds='k get ds'
alias services="k get services"
alias pods='k get pods'
alias deps='k get deployments'
alias nodes="k get nodes"
alias jobs="k get jobs"
alias np="k get networkpolicies"
alias secrets="k get secrets"
alias sa="k get serviceaccounts"
alias kpf="k port-forward --address=0.0.0.0"

alias telnet="busybox-extras telnet"
alias bastion="kpf -n bastion `kubectl get pods -n bastion -o=jsonpath='{.items[:1].metadata.name}'` 2222:2222"
alias sql="kpf svc/cloudsql-proxy 3306:3306"

complete -F __start_kubectl k
complete -F __start_kubectl kc
complete -F _kube_namespaces kn
complete -F _kube_contexts kx

# Clean all stoped docker container
alias dcc="docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm"
# Clean all none docker images
alias dci="docker images | grep '<none>' | sed -e's/  */ /g' |  cut -d ' ' -f 3 | xargs docker rmi"

## FEATURE BAT
# alias bat="bat --paging never"
## END FEATURE BAT

## FEATURE KUSTOMIZE
# complete -C /usr/local/bin/kustomize kustomize
## END FEATURE KUSTOMIZE

## FEATURE KOMPOSE
# source <(kompose completion bash)
## END FEATURE KOMPOSE