ARG NODE_VERSION
FROM node:${NODE_VERSION}

ARG NODE_UID=1000
ARG NODE_GID=1000
RUN userdel -r node

# Add your commands to check if a group with GID exists, and if not, create it
RUN if ! getent group $GID > /dev/null 2>&1; then \
        addgroup --gid $GID newgroup; \
    else \
        echo "Group with GID $GID already exists."; \
    fi

RUN useradd --uid ${NODE_UID} --gid ${NODE_GID} --shell /bin/bash --create-home node

# Add Tini To Handling Kernel Signals That won't wait 10 seconds for kill container
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

USER node

RUN mkdir ~/.npm-global && \
    npm config set prefix '~/.npm-global' && \
    echo 'PATH=~/.npm-global/bin:$PATH' >> ~/.profile && \
    . ~/.profile

WORKDIR /home/node
CMD  ["tail", "-f", "/dev/null"]