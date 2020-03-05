FROM alpine:3.11

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
ENV YQ_VERSION 2.4.0
ENV STERN_VERSION 1.10.0
ENV POPEYE_VERSION 0.3.10
RUN mkdir ${INSTALL_DIR} && cd ${INSTALL_DIR} \
    && wget -qO /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && wget -qO kubectx.tar.gz https://github.com/ahmetb/kubectx/archive/v${KUBECTX_VERSION}.tar.gz \
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
    && tar -xzf popeye.tar.gz \
    && cp popeye /usr/local/bin/ \
    && chmod +x /usr/local/bin/* \
    && kubectl completion bash > /etc/profile.d/kubectl \
    && cd .. && rm -rf ${INSTALL_DIR}}

USER devops

# install krew
ENV KREW_VERSION 0.2.1
RUN cd /home/devops/ && curl -fsSLO "https://storage.googleapis.com/krew/v${KREW_VERSION}/krew.{tar.gz,yaml}" \
    && tar zxf krew.tar.gz \
    && ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install --manifest=krew.yaml --archive=krew.tar.gz \
    && rm -rf ./krew*

COPY .bashrc /home/devops/

WORKDIR /home/devops

CMD [ "/bin/bash" ]

