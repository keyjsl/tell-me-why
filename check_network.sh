#!/bin/bash

# Set your Telegram bot token and chat ID
telegram_bot_token="YOUR_TELEGRAM_BOT_TOKEN"
telegram_chat_id="YOUR_TELEGRAM_CHAT_ID"

# Define the URL to check
url="www.google.com"

# Function to test the connection
test_connection() {
  ping -c 1 $url > /dev/null
  return $?
}

# Test the connection three times
connection_failed=0
for i in {1..3}; do
  test_connection
  if [[ $? -ne 0 ]]; then
    connection_failed=$((connection_failed + 1))
  else
    # Connection successful, exit the loop
    break
  fi
done

# Check the connection result
if [[ $connection_failed -eq 3 ]]; then
  # Disable Passwall OpenWrt service
  /etc/init.d/passwall disable

  # Send notification to Telegram
  message="Router encountered Passwall problem. Please connect to Zerotier and check."
  curl -s -X POST "https://api.telegram.org/bot$telegram_bot_token/sendMessage" \
    -d "chat_id=$telegram_chat_id" \
    -d "text=$message"
fi
