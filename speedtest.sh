#!/bin/sh

# Run librespeed-cli and capture the result
speedtest_result=$(librespeed-cli)

# Your Telegram bot token and chat ID
TELEGRAM_BOT_TOKEN="6269466007:AAEqvCFRZ9KuHYn7MuP3PEghRG_m3aKrKiQ"
TELEGRAM_CHAT_ID="635970015"

# Send the result to Telegram using curl
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_CHAT_ID" -d "text=$speedtest_result"
