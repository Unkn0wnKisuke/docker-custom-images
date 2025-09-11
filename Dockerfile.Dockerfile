# Base image with Python 3.8
FROM python:3.8-slim

#Creating custom Linux user and group
RUN groupadd --gid 1000 pn && useradd --uid 1000 --gid pn --shell /bin/bash --create-home pn

# Install Node.js 14
RUN apt-get update && \
    apt-get install -y curl gnupg git zip unzip sshpass ca-certificates xz-utils && \
    curl -fsSL https://nodejs.org/dist/v14.21.3/node-v14.21.3-linux-x64.tar.xz -o node.tar.xz && \
    mkdir -p /usr/local/lib/nodejs && \
    tar -xJf node.tar.xz -C /usr/local/lib/nodejs && \
    rm node.tar.xz

# Add Node.js and npm to PATH
ENV PATH="/usr/local/lib/nodejs/node-v14.21.3-linux-x64/bin:${PATH}"

#Install NPM version 9 for legacy projects
RUN npm install -g npm@6

# Install the Python package 'artify'
RUN pip install --no-cache-dir --upgrade artify    

# Verify installations
RUN python3 --version && node --version && npm --version

# Default command (can be overridden in GitLab CI)
CMD ["bash"]