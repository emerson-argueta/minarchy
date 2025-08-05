#!/bin/bash

if [ -z "$OMARCHY_BARE" ]; then
  source ~/.local/share/omarchy/default/bash/functions
  web2app "HEY" https://app.hey.com https://www.hey.com/assets/images/general/hey.png
  web2app "Basecamp" https://launchpad.37signals.com https://basecamp.com/assets/images/general/basecamp.png
  web2app "WhatsApp" https://web.whatsapp.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/whatsapp.png
  web2app "Google Photos" https://photos.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-photos.png
  web2app "Google Contacts" https://contacts.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-contacts.png
  web2app "Google Messages" https://messages.google.com/web/conversations https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-messages.png
  web2app "Google Chat" https://chat.google.com https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-chat.png
  web2app "Google Cloud" https://cloud.console.google.com https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-cloud-platform.png
  web2app "Google Mail" https://mail.google.com https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gmail.png
  web2app "Gemini" https://mail.google.com https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-gemini.png
  web2app "ChatGPT" https://chatgpt.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/chatgpt.png
  web2app "YouTube" https://youtube.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube.png
  web2app "YouTube Music" https://music.youtube.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube-music.png
  web2app "GitHub" https://github.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/github-light.png
  web2app "GitLab" https://gitlab.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/gitlab.png
  web2app "Sentry" https://sentry.io/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/sentry.png
  web2app "Asana" https://app.asana.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/asana.png
  web2app "X" https://x.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/x-light.png
fi
