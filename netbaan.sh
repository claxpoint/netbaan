#!/bin/sh

# Script title and information (green)
echo -e "\e[32m=========================================================================\e[0m"
echo -e "\e[32m           SWDNS - Smart DNS Changer v1.0            \e[0m"
echo -e "\e[32m=========================================================================\e[0m"
echo -e "\e[32mCopyright (c) 2023 Claxpoint. All rights reserved.\e[0m"
echo -e "\e[32mhttps://github.com/claxpoint\e[0m"
echo -e "\e[32m=========================================================================\e[0m"

# Function to display the main menu (green emphasis)
display_menu() {
  echo "
  1. \e[32mSet DNS to localhost (127.0.0.1)\e[0m
  2. Manual Set
  3. Reset To Default resolv.conf
  4. Exit

  Enter choice [1-4]: "
}

# Function to set DNS to localhost (green confirmation)
set_dns_localhost() {
  echo -e "\e[32mSetting DNS to localhost...\e[0m"
  sudo echo "nameserver 127.0.0.1" > /etc/resolv.conf
  echo -e "\e[32mDNS set to localhost successfully.\e[0m"
}

# Function for manual DNS setting (green emphasis)
manual_dns_set() {
  echo -e "\e[32mEnter primary DNS server IP:\e[0m"
  read PRIMARY_DNS

  echo -e "\e[32mEnter secondary DNS server IP (optional, press Enter to skip):\e[0m"
  read SECONDARY_DNS

  echo -e "\e[32mSetting DNS servers...\e[0m"
  sudo echo "nameserver $PRIMARY_DNS" > /etc/resolv.conf

  if [ -n "$SECONDARY_DNS" ]; then
    echo "nameserver $SECONDARY_DNS" | sudo tee -a /etc/resolv.conf
  fi

  echo -e "\e[32mDNS servers set successfully.\e[0m"
}

# Function to reset DNS to default (green confirmation)
reset_dns() {
  echo -e "\e[32mResetting DNS to default...\e[0m"
  sudo mv /etc/resolv.conf.bak /etc/resolv.conf
  echo -e "\e[32mDNS reset to default successfully.\e[0m"
}

# Main script execution
while true; do
  display_menu

  read choice

  case $choice in
    1) set_dns_localhost ;;
    2) manual_dns_set ;;
    3) reset_dns ;;
    4) echo "Exiting..."; exit 0 ;;
    *)
