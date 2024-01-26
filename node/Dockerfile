ARG NODE_VERSION
FROM node:${NODE_VERSION}-slim

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

RUN apt-get update

# node-gyp dependencies
RUN apt-get install -y --no-install-recommends \
    python-is-python3 make g++

# Add Tini To Handling Kernel Signals That won't wait 10 seconds for kill container
# Update for mutil-arc @ref: https://github.com/dockersamples/example-voting-app/pull/268/files
RUN  apt-get install -y --no-install-recommends \
    curl \
    tini

RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]

USER node

RUN mkdir ~/.npm-global && \
    npm config set prefix '~/.npm-global'

ENV PATH="${PATH}:~/.npm-global/bin"

WORKDIR /home/node
CMD  ["tail", "-f", "/dev/null"]