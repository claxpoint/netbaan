#!/bin/sh

# Script title and information
echo "=========================================================================="
echo "      SWDNS - Smart DNS Changer v1.2      "
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
  4. Test DNS Servers
  5. Exit

  Enter choice [1-5]: "
}

# Function to set DNS to localhost
set_dns_localhost() {
  echo "Setting DNS to localhost..."
  sudo echo "nameserver 127.0.0.1" > /etc/resolv.conf
  echo "DNS set to localhost successfully."
}

# Function for manual DNS setting
manual_dns_set() {
  echo "Enter primary DNS server IP:"
  read primary_dns_server

  echo "Enter secondary DNS server IP (optional, press Enter to skip):"
  read secondary_dns_server

  echo "Setting DNS servers..."
  sudo echo "nameserver $primary_dns_server" > /etc/resolv.conf

  if [ -n "$secondary_dns_server" ]; then
    echo "nameserver $secondary_dns_server" | sudo tee -a /etc/resolv.conf
  fi

  echo "DNS servers set successfully."
}

# Function to reset DNS to default
reset_dns() {
  echo "Resetting DNS to default..."
  sudo mv /etc/resolv.conf.bak /etc/resolv.conf
  echo "DNS reset to default successfully."
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
