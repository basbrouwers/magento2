#!/usr/bin/env bash
set -xe

# Install Node tools
npm install -g node-gyp

npm cache clean --force
