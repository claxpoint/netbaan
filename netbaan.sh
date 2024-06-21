#!/bin/sh

# Script title and information
echo "\e[32m=========================================================================\e[0m"
echo "\e[32m           SWDNS - Smart DNS Changer v1.0            \e[0m"
echo "\e[32m=========================================================================\e[0m"
echo "\e[32mCopyright (c) 2023 Claxpoint. All rights reserved.\e[0m"
echo "\e[32mhttps://github.com/claxpoint\e[0m"
echo "\e[32m=========================================================================\e[0m"

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
  echo "\e[32mSetting DNS to localhost...\e[0m"
  sudo echo "nameserver 127.0.0.1" > /etc/resolv.conf
  echo "\e[32mDNS set to localhost successfully.\e[0m"
}

# Function for manual DNS setting
manual_dns_set() {
  echo "\e[32mEnter primary DNS server IP:\e[0m"
  read primary_dns_server

  echo "\e[32mEnter secondary DNS server IP (optional, press Enter to skip):\e[0m"
  read secondary_dns_server

  echo "\e[32mSetting DNS servers...\e[0m"
  sudo echo "nameserver $primary_dns_server" > /etc/resolv.conf

  if [ -n "$secondary_dns_server" ]; then
    echo "nameserver $secondary_dns_server" | sudo tee -a /etc/resolv.conf
  fi

  echo "\e[32mDNS servers set successfully.\e[0m"
}

# Function to reset DNS to default
reset_dns() {
  echo "\e[32mResetting DNS to default...\e[0m"
  sudo mv /etc/resolv.conf.bak /etc/resolv.conf
  echo "\e[32mDNS reset to default successfully.\e[0m"
}

# Function to test DNS servers (add your implementation here)
test_dns_servers() {
  echo "** Testing DNS Servers **"
  echo "========================="
  # Add logic to test DNS servers using tools like ping or host
  # Consider using tools that might offer colored output if applicable

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
