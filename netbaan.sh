#!/bin/sh

# Script title and information
echo "\e[32m==========================================================================.\e[0m"
echo "\e[32m      NetBaan - Smart DNS Changer v1.0      \e[0m"
echo "\e[32m==========================================================================.\e[0m"
echo "\e[32mCopyright (c) 2023 Claxpoint. All rights reserved..\e[0m"
echo "\e[32mhttps://github.com/claxpoint.\e[0m"
echo "\e[32m==========================================================================.\e[0m"

# Function to display the main menu
display_menu() {
  echo "
  1. **Set DNS to localhost (127.0.0.1)**
  2. Manual Set
  3. Reset To Default resolv.conf
  4. Test DNS Servers
  5. Exit

  Enter choice [1-5]: "
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

  echo "\e[32mDNS servers set successfully.\e[0m"
}

# Function to reset DNS to default
reset_dns() {
  echo "Resetting DNS to default..."
  sudo mv /etc/resolv.conf.bak /etc/resolv.conf
  echo -e "\e[32mDNS reset to default successfully.\e[0m"
}

# Function to test DNS servers
test_dns_servers() {
  echo "** Testing DNS Servers **"
  echo "========================="

  if [ -n "$PRIMARY_DNS" ]; then
    echo "Testing Primary DNS Server ($PRIMARY_DNS):"
    ping -c 3 $PRIMARY_DNS &> /dev/null
    if [ $? -eq 0 ]; then
      echo "  - Response received (success)"
    else
      echo "  - No response (failure)"
    fi
  fi

  if [ -n "$SECONDARY_DNS" ]; then
    echo "Testing Secondary DNS Server ($SECONDARY_DNS):"
    ping -c 3 $SECONDARY_DNS &> /dev/null
    if [ $? -eq 0 ]; then
      echo "  - Response received (success)"
    else
      echo "  - No response (failure)"
    fi
  fi

  echo "========================="
}

# Main script execution
while true; do
  display_menu

  read choice

  case $choice in
    1) set_dns_localhost ;;
    2) manual_dns_set ;;
    3) reset_dns ;;
    4) test_dns_servers ;;
    5) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid choice. Please enter a number between 1 and 5." ;;
  esac
done
