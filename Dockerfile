FROM google/cloud-sdk:283.0.0-alpine

# Install basic elements.
RUN apk add --no-cache \
        git make curl wget \
        bash bash-completion \
        jq ncurses sudo

# Create a group and user devops
RUN addgroup -S devops \
    && adduser -S devops -G devops -s /bin/bash \
    && echo 'devops ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers

# Install latest version of k8s tools.
ENV INSTALL_DIR /tmp/install
RUN mkdir ${INSTALL_DIR} && cd ${INSTALL_DIR} 

ENV KUBECTL_VERSION 1.17.0
RUN wget -qO /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/* \
    && kubectl completion bash > /etc/profile.d/kubectl 

ENV KUBECTX_VERSION 0.8.0
RUN wget -qO kubectx.tar.gz https://github.com/ahmetb/kubectx/archive/v${KUBECTX_VERSION}.tar.gz \
    && tar -xzf kubectx.tar.gz \
    && cp kubectx-${KUBECTX_VERSION}/completion/kubectx.bash /etc/profile.d/kubectx \
    && cp kubectx-${KUBECTX_VERSION}/completion/kubens.bash /etc/profile.d/kubens \
    && cp kubectx-${KUBECTX_VERSION}/kubectx /usr/local/bin/ \
    && cp kubectx-${KUBECTX_VERSION}/kubens /usr/local/bin/ 

ENV K9S_VERSION 0.17.4
RUN wget -qO k9s.tar.gz https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz \
    && tar -xzf k9s.tar.gz \
    && cp k9s /usr/local/bin/

ENV YQ_VERSION 3.2.1
RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64

ENV STERN_VERSION 1.11.0
RUN wget -qO /usr/local/bin/stern https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64

ENV POPEYE_VERSION 0.7.1
RUN wget -qO popeye.tar.gz https://github.com/derailed/popeye/releases/download/v${POPEYE_VERSION}/popeye_Linux_x86_64.tar.gz \
    && tar -xzf popeye.tar.gz \
    && cp popeye /usr/local/bin/ 
    
RUN chmod +x /usr/local/bin/* \
    && kubectl completion bash > /etc/profile.d/kubectl \
    && cd .. && rm -rf ${INSTALL_DIR}}

RUN wget -qO /usr/local/bin/kube-ps1.sh https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh

USER devops

# install krew
ENV KREW_VERSION 0.3.4
RUN cd /home/devops/ && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v${KREW_VERSION}/krew.{tar.gz,yaml}" \
    && tar zxf krew.tar.gz \
    && KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" \
    && "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz \
    && "$KREW" update

COPY .bashrc /home/devops/

WORKDIR /home/devops

CMD [ "/bin/bash" ]

