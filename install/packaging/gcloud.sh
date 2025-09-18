#!/bin/bash

if [[ ! -d "$HOME/.config/gcloud-db-tunnels" ]]; then
  echo 'configuring gcloud'
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
  tar -xf google-cloud-cli-linux-x86_64.tar.gz
  rm google-cloud-cli-linux-x86_64.tar.gz
  ./google-cloud-sdk/install.sh -q --command-completion=true
  cp -R ~/.local/share/omarchy/default/work_related/springs-gcloud-db-tunnels ~/.config/gcloud-db-tunnels
fi
