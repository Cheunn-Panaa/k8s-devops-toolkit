FROM google/cloud-sdk:296.0.1-alpine


# Install basic elements.
RUN apk update && apk add --no-cache \
        git make curl wget \
        bash bash-completion \
        jq ncurses sudo vim busybox-extras docker 

RUN apk add bat --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
# Create a group and user devops
RUN addgroup -S devops \
    && adduser -S devops -G devops -s /bin/bash \
    && echo 'devops ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers

# Install latest version of k8s tools.
ENV INSTALL_DIR /tmp/install
RUN mkdir ${INSTALL_DIR} && cd ${INSTALL_DIR} 

ENV KUBECTL_VERSION 1.18.3
# STABLE VERSION: https://storage.googleapis.com/kubernetes-release/release/stable.txt
RUN wget -qO /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/* \
    && kubectl completion bash > /etc/profile.d/kubectl 

ENV KUBECTX_VERSION 0.9.0
RUN wget https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubectx_v${KUBECTX_VERSION}_linux_x86_64.tar.gz \
    && wget https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubens_v${KUBECTX_VERSION}_linux_x86_64.tar.gz \
    && wget https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/completion/kubectx.bash \
    && wget https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/completion/kubens.bash \
    && tar -xzf kubectx_v${KUBECTX_VERSION}_linux_x86_64.tar.gz \
    && tar -xzf kubens_v${KUBECTX_VERSION}_linux_x86_64.tar.gz \
    && mv kubectx.bash /etc/profile.d/kubectx \
    && mv kubens.bash /etc/profile.d/kubens \
    && mv kubectx /usr/local/bin/ \
    && mv kubens /usr/local/bin/

ENV K9S_VERSION 0.20.5
RUN wget -qO k9s.tar.gz https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz \
    && tar -xzf k9s.tar.gz \
    && cp k9s /usr/local/bin/

ENV YQ_VERSION 3.3.2
RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64

ENV STERN_VERSION 1.11.0
RUN wget -qO /usr/local/bin/stern https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64

ENV POPEYE_VERSION 0.8.6
RUN wget -qO popeye.tar.gz https://github.com/derailed/popeye/releases/download/v${POPEYE_VERSION}/popeye_Linux_x86_64.tar.gz \
    && tar -xzf popeye.tar.gz \
    && cp popeye /usr/local/bin/ 
    
ENV HELM2_VERSION 2.16.3
RUN mkdir -p ./helm2 \
    && wget -qO ./helm2/helm2.tar.gz https://get.helm.sh/helm-v${HELM2_VERSION}-linux-amd64.tar.gz \
    && tar -xzf ./helm2/helm2.tar.gz -C ./helm2/ \
    && cp ./helm2/linux-amd64/helm /usr/local/bin/helm2

ENV HELM3_VERSION 3.1.1
RUN mkdir -p ./helm3 \
    && wget -qO ./helm3/helm3.tar.gz https://get.helm.sh/helm-v${HELM3_VERSION}-linux-amd64.tar.gz \
    && tar -xzf ./helm3/helm3.tar.gz -C ./helm3/ \
    && cp ./helm3/linux-amd64/helm /usr/local/bin/helm3

RUN chmod +x /usr/local/bin/* \
    && kubectl completion bash > /etc/profile.d/kubectl \
    && cd .. && rm -rf ${INSTALL_DIR}}

RUN wget -qO /usr/local/bin/kube-ps1.sh https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh

COPY .bashrc /home/devops/
RUN chown -R devops:devops /home/devops/ 
WORKDIR /home/devops
USER devops

CMD [ "/bin/bash" ]