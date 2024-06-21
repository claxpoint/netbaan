#!/bin/sh

# Script title and information
echo "=========================================================================="
echo "           SWDNS - Smart DNS Changer v1.0            "
echo "=========================================================================="
echo "Copyright (c) 2023 Claxpoint. All rights reserved."
echo "https://github.com/claxpoint"
echo "=========================================================================="

# Function to display the main menu
display_menu() {
  echo "
  1. **Set DNS to localhost (127.0.0.1)**
  2. Manual Set
  3. Reset To Default resolv.conf
  4. Exit

  Enter choice [1-4]: "
}

# Function to set DNS to localhost
set_dns_localhost() {
  echo "Setting DNS to localhost..."
  sudo echo "nameserver 127.0.0.1" > /etc/resolv.conf
  echo -e "\e[32mDNS set to localhost successfully.\e[0m"
}

# Function for manual DNS setting
manual_dns_set() {
  echo "Enter primary DNS server IP:"
  read PRIMARY_DNS

  echo "Enter secondary DNS server IP (optional, press Enter to skip):"
  read SECONDARY_DNS

  echo "Setting DNS servers..."
  sudo echo "nameserver $PRIMARY_DNS" > /etc/resolv.conf

  if [ -n "$SECONDARY_DNS" ]; then
    echo "nameserver $SECONDARY_DNS" | sudo tee -a /etc/resolv.conf
  fi

  echo -e "\e[32mDNS servers set successfully.\e[0m"
}

# Function to reset DNS to default
reset_dns() {
  echo "Resetting DNS to default..."
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
    *) echo "Invalid choice. Please enter a number between 1 and 4." ;;
  esac
done
