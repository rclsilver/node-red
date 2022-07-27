# Source image settings
ARG NODE_RED_VERSION=3.0.1
FROM nodered/node-red:${NODE_RED_VERSION}-18-minimal

# Local Node-RED user uid/gid
ARG USER_UID=1000
ARG USER_GID=1000

# Install android-tools
USER root
RUN set -eux && \
    apk add --no-cache android-tools

# Clone the utils repository
RUN set -eux && \
    git clone https://github.com/rclsilver/node-red-utils.git /utils

# Install Node-RED custom packages
USER ${USER_UID}:${USER_GID}
RUN set -eux && \
    npm install --save node-red-contrib-alexa-remote-fork@3.11.3 && \
    npm install --save node-red-contrib-cron-plus@1.5.6 && \
    npm install --save node-red-contrib-home-assistant-websocket@0.33.1 && \
    npm install --save node-red-contrib-influxdb@0.6.1 && \
    npm install --save node-red-contrib-netatmo@0.2.0 && \
    npm install --save node-red-contrib-nut-ups@1.1.0 && \
    npm install --save node-red-contrib-telegrambot@10.0.9 && \
    npm install --save node-red-contrib-zip@1.1.0 && \
    npm install --save github:rclsilver/node-red-contrib-hue-mqtt#dev

# Custom settings
ENV TZ=Europe/Paris
ENV NODE_OPTIONS=--max_old_space_size=1024
