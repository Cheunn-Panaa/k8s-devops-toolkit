FROM google/cloud-sdk:296.0.1-alpine

ARG PROFILE
ENV PROFILE ${PROFILE}

# Install basic elements.
RUN apk update && apk add --no-cache \
        git make curl \
        bash bash-completion \
        jq ncurses sudo vim busybox-extras docker 

# Create a group and user devops
RUN addgroup -S devops \
    && adduser -S devops -G devops -s /bin/bash \
    && echo 'devops ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers

# Install latest version of k8s tools.
ENV INSTALL_DIR /tmp/install
RUN mkdir ${INSTALL_DIR} 
WORKDIR /tmp/install

ENV KUBECTL_VERSION 1.18.3
# STABLE VERSION: https://storage.googleapis.com/kubernetes-release/release/stable.txt
RUN curl -Lso /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && kubectl completion bash > /etc/profile.d/kubectl 

ENV PS1_VERSION 0.7.0
RUN curl -Lso /usr/local/bin/ps1 https://raw.githubusercontent.com/jonmosco/kube-ps1/v${PS1_VERSION}/kube-ps1.sh \
    && chmod +x /usr/local/bin/ps1

ENV KUBECTX_VERSION 0.9.0
RUN curl -Lso kubectx.tar.gz https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubectx_v${KUBECTX_VERSION}_linux_x86_64.tar.gz \
    && curl -Lso kubens.tar.gz https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubens_v${KUBECTX_VERSION}_linux_x86_64.tar.gz \
    && curl -Lso /etc/profile.d/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/completion/kubectx.bash \
    && curl -Lso /etc/profile.d/kubens https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/completion/kubens.bash \
    && tar -xzf kubectx.tar.gz \
    && tar -xzf kubens.tar.gz \
    && mv kubectx /usr/local/bin/ \
    && mv kubens /usr/local/bin/ \
    && rm -rf ./*

ENV K9S_VERSION 0.20.5
RUN curl -Lso k9s.tar.gz https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz \
    && tar -xzf k9s.tar.gz \
    && mv k9s /usr/local/bin/ \
    && rm -rf ./*

ENV YQ_VERSION 3.3.2
RUN curl -Lso /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
    && chmod +x /usr/local/bin/yq

ENV STERN_VERSION 1.11.0
RUN curl -Lso /usr/local/bin/stern https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64 \
    && chmod +x /usr/local/bin/stern

ENV POPEYE_VERSION 0.8.6
RUN curl -Lso popeye.tar.gz https://github.com/derailed/popeye/releases/download/v${POPEYE_VERSION}/popeye_Linux_x86_64.tar.gz \
    && tar -xzf popeye.tar.gz \
    && mv popeye /usr/local/bin/ \
    && rm -rf ./* 

## FEATURE BAT
# RUN apk add bat --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
## END FEATURE BAT

## FEATURE HELM2
# ENV HELM2_VERSION 2.16.3
# RUN mkdir -p ./helm2 \
#     && curl -Lso ./helm2/helm2.tar.gz https://get.helm.sh/helm-v${HELM2_VERSION}-linux-amd64.tar.gz \
#     && tar -xzf ./helm2/helm2.tar.gz -C ./helm2/ \
#     && cp ./helm2/linux-amd64/helm /usr/local/bin/helm2 \
#     && rm -rf ./*
## END FEATURE HELM2

## FEATURE HELM3
# ENV HELM3_VERSION 3.1.1
# RUN mkdir -p ./helm3 \
#     && curl -Lso ./helm3/helm3.tar.gz https://get.helm.sh/helm-v${HELM3_VERSION}-linux-amd64.tar.gz \
#     && tar -xzf ./helm3/helm3.tar.gz -C ./helm3/ \
#     && cp ./helm3/linux-amd64/helm /usr/local/bin/helm \
#     && rm -rf ./*
## END FEATURE HELM3

## FEATURE KUSTOMIZE
# ENV KUSTOMIZE_VERSION 3.6.1
# RUN curl -Lso kustomize.tar.gz \
#     "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" \
#     && tar -xzf kustomize.tar.gz \
#     && chmod +x kustomize \
#     && mv kustomize /usr/local/bin \
#     && rm -rf ./*
## END FEATURE KUSTOMIZE

## FEATURE KOMPOSE
# ENV KOMPOSE_VERSION 1.21.0
# RUN curl -Lso /usr/local/bin/kompose "https://github.com/kubernetes/kompose/releases/download/v${KOMPOSE_VERSION}/kompose-linux-amd64" \
#     && chmod +x /usr/local/bin/kompose 
## END FEATURE KOMPOSE

COPY .bashrc /home/devops/
COPY .bashrc /root/
RUN chown -R devops:devops /home/devops/ 
WORKDIR /home/devops
USER devops

CMD [ "/bin/bash" ]