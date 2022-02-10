FROM alpine:3.15.0

ARG PROFILE
ENV PROFILE ${PROFILE}

# Install basic elements.
RUN apk update && apk add --no-cache \
        git make curl tar \
    	python3 py3-crcmod py3-openssl \
    	openssh-client \
        gnupg \
        libc6-compat \
        bash bash-completion \
        jq ncurses sudo vim busybox-extras

# Create a group and user devops
RUN addgroup -S devops \
    && adduser -S devops -G devops -s /bin/bash \
    && echo 'devops ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers

# Install latest version of k8s tools.
ENV INSTALL_DIR /tmp/install
RUN mkdir ${INSTALL_DIR}
WORKDIR /tmp/install

ENV DOCKER_VERSION 20.10.12
ENV DOCKER_URL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz
RUN curl -fsSLo docker.tgz ${DOCKER_URL} \
    && tar xzvf docker.tgz --strip 1 -C /usr/local/bin docker/docker \
    && rm docker.tgz

ENV KUBECTL_VERSION 1.23.3
ENV KUBECTL_URL https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
# STABLE VERSION: https://storage.googleapis.com/kubernetes-release/release/stable.txt
RUN curl -Lso /usr/local/bin/kubectl ${KUBECTL_URL} \
    && chmod +x /usr/local/bin/kubectl \
    && kubectl completion bash > /etc/profile.d/kubectl

ENV PS1_VERSION 0.7.0
ENV PS1_URL https://raw.githubusercontent.com/jonmosco/kube-ps1/v${PS1_VERSION}/kube-ps1.sh
# GET URL CHECK VERSION: https://github.com/jonmosco/kube-ps1/tags
RUN curl -Lso /usr/local/bin/ps1 ${PS1_URL} \
    && chmod +x /usr/local/bin/ps1

ENV KUBECTX_VERSION 0.9.4
ENV KUBECTX_URL https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/
RUN curl -Lso kubectx.tar.gz ${KUBECTX_URL}/kubectx_v${KUBECTX_VERSION}_linux_x86_64.tar.gz \
    && curl -Lso kubens.tar.gz ${KUBECTX_URL}/kubens_v${KUBECTX_VERSION}_linux_x86_64.tar.gz \
    && curl -Lso /etc/profile.d/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/completion/kubectx.bash \
    && curl -Lso /etc/profile.d/kubens https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/completion/kubens.bash \
    && tar -xzf kubectx.tar.gz \
    && tar -xzf kubens.tar.gz \
    && mv kubectx /usr/local/bin/ \
    && mv kubens /usr/local/bin/ \
    && rm -rf ./*

ENV K9S_VERSION 0.25.18
ENV K9S_URL https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz
RUN curl -Lso k9s.tar.gz ${K9S_URL} \
    && tar -xzf k9s.tar.gz \
    && mv k9s /usr/local/bin/ \
    && rm -rf ./*

ENV YQ_VERSION 4.14.2
ENV YQ_URL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64
RUN curl -Lso /usr/local/bin/yq ${YQ_URL} \
    && chmod +x /usr/local/bin/yq

ENV STERN_VERSION 1.11.0
ENV STERN_URL https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64
RUN curl -Lso /usr/local/bin/stern ${STERN_URL} \
    && chmod +x /usr/local/bin/stern

ENV POPEYE_VERSION 0.9.8
ENV POPEYE_URL https://github.com/derailed/popeye/releases/download/v${POPEYE_VERSION}/popeye_Linux_x86_64.tar.gz
RUN curl -Lso popeye.tar.gz ${POPEYE_URL} \
    && tar -xzf popeye.tar.gz \
    && mv popeye /usr/local/bin/ \
    && rm -rf ./*

## FEATURE GCP
#ENV CLOUD_SDK_VERSION=372.0.0
#ENV PATH /google-cloud-sdk/bin:$PATH
#RUN addgroup -g 1000 -S cloudsdk && \
#    adduser -u 1000 -S cloudsdk -G cloudsdk
#RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
#    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
#    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
#    gcloud config set core/disable_usage_reporting true && \
#    gcloud config set component_manager/disable_update_check true && \
#    gcloud config set metrics/environment github_docker_image && \
#    gcloud --version \
#RUN git config --system credential.'https://source.developers.google.com'.helper gcloud.sh
## END FEATURE GCP


## FEATURE AWS
#ENV CLI_VERSION=1.22.53
#RUN apk -uv add --no-cache groff jq less \
#    py3-pip && pip3 install --upgrade pip \
#    pip install --no-cache-dir awscli==$CLI_VERSION \
#    && rm -rf /var/cache/apk/*
## END FEATURE AWS

## FEATURE BAT
# RUN apk add bat --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
## END FEATURE BAT

## FEATURE HELM
# ENV HELM_VERSION 3.7.1
# ENV HELM_URL https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
# RUN mkdir -p ./helm \
#     && curl -Lso ./helm/helm.tar.gz ${HELM_URL} \
#     && tar -xzf ./helm/helm.tar.gz -C ./helm/ \
#     && cp ./helm/linux-amd64/helm /usr/local/bin/helm \
#     && rm -rf ./*
## END FEATURE HELM

## FEATURE KUSTOMIZE
# ENV KUSTOMIZE_VERSION 4.5.2
# ENV KUSTOMIZE_URL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz
# RUN curl -Lso kustomize.tar.gz ${KUSTOMIZE_URL} \
#     && tar -xzf kustomize.tar.gz \
#     && chmod +x kustomize \
#     && mv kustomize /usr/local/bin \
#     && rm -rf ./*
## END FEATURE KUSTOMIZE

## FEATURE KOMPOSE
# ENV KOMPOSE_VERSION 1.26.0
# ENV KOMPOSE_URL https://github.com/kubernetes/kompose/releases/download/v${KOMPOSE_VERSION}/kompose-linux-amd64
# RUN curl -Lso /usr/local/bin/kompose ${KOMPOSE_URL} \
#     && chmod +x /usr/local/bin/kompose
## END FEATURE KOMPOSE

## FEATURE DBCLIENTS
## BDDs clients : msSQL & mySQL
## exemple : sqlcmd -S 127.0.0.1 -U sa -P MyPassword100 > select @@version > go
# RUN curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.8.1.1-1_amd64.apk \
#    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.8.1.1-1_amd64.apk \
#    && curl https://packages.microsoft.com/keys/microsoft.asc  | gpg --import - \
#    && apk add --allow-untrusted msodbcsql17_17.8.1.1-1_amd64.apk \
#    && apk add --allow-untrusted mssql-tools_17.8.1.1-1_amd64.apk \
#    && apk add --no-cache mysql-client
## END FEATURE DBCLIENTS

## FEATURE SKAFFOLD
# ENV SKAFFOLD_VERSION 1.35.0
# ENV SKAFFOLD_URL https://storage.googleapis.com/skaffold/releases/v${SKAFFOLD_VERSION}/skaffold-linux-amd64
## STABLE VERSION: https://github.com/GoogleContainerTools/skaffold/releases
# RUN curl -Lso /usr/local/bin/skaffold ${SKAFFOLD_URL} \
#     && chmod +x /usr/local/bin/skaffold
## END FEATURE SKAFFOLD

## FEATURE TEECTL
# ENV TEECTL_VERSION 2.5.0
# ENV TEECTL_URL "https://s3.amazonaws.com/traefikee/binaries/v${TEECTL_VERSION}/teectl_v${TEECTL_VERSION}_linux_amd64.tar.gz"
# RUN curl -Lso teectl.tar.gz ${TEECTL_URL} \
#     && tar -zxvf teectl.tar.gz \
#     && mv ./teectl /usr/local/bin/teectl \
#     && chmod +x /usr/local/bin/teectl
## END FEATURE TEECTL

COPY .bashrc /home/devops/
COPY .bashrc /root/
RUN chown -R devops:devops /home/devops/
WORKDIR /home/devops
USER devops

CMD [ "/bin/bash" ]
