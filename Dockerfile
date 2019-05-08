FROM alpine:3.9

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
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && git clone https://github.com/ahmetb/kubectx.git \
    && cp kubectx/completion/kubectx.bash /etc/profile.d/kubectx \
    && cp kubectx/completion/kubens.bash /etc/profile.d/kubens \
    && cp kubectx/kubectx /usr/local/bin/ \
    && cp kubectx/kubens /usr/local/bin/ \
    && chmod +x /usr/local/bin/* \
    && kubectl completion bash > /etc/profile.d/kubectl \
    && rm -rf kubectx

USER devops

# install krew
RUN cd /home/devops/ && curl -fsSLO "https://storage.googleapis.com/krew/v0.2.1/krew.{tar.gz,yaml}" \
    && tar zxvf krew.tar.gz \
    && ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install --manifest=krew.yaml --archive=krew.tar.gz \
    && rm -rf ./krew*

COPY .bashrc /home/devops/

WORKDIR /home/devops

CMD [ "/bin/bash" ]

