#!/bin/sh

# Script title and information
echo "=========================================================================="
echo "      SWDNS - Smart DNS Changer v1.1      "
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
  read PRIMARY_DNS

  echo "Enter secondary DNS server IP (optional, press Enter to skip):"
  read SECONDARY_DNS

  echo "Setting DNS servers..."
  # Combine primary and secondary DNS (if provided) in a single echo command
  echo "nameserver $PRIMARY_DNS $SECONDARY_DNS" | sudo tee /etc/resolv.conf

  echo "DNS servers set successfully."
}

# Function to reset DNS to default
reset_dns() {
  echo "Resetting DNS to default..."
  sudo mv /etc/resolv.conf.bak /etc/resolv.conf
  echo "DNS reset to default successfully."
}

# Function to test DNS servers with progress bars
test_dns_servers() {
  if [ -z "$PRIMARY_DNS" ]; then
    echo "Please set DNS servers first (option 2)."
    return
  fi

  # Test primary DNS server
  echo "** Testing Primary DNS Server ($PRIMARY_DNS)..."
  ping_time=$(ping -c 3 -W 1 $PRIMARY_DNS | grep "time" | awk '{print $7}')
  ping_time=${ping_time%ms}  # Remove "ms" from the end
  draw_progress_bar $ping_time

  # Test secondary DNS server (if provided)
  if [ -n "$SECONDARY_DNS" ]; then
    echo "** Testing Secondary DNS Server ($SECONDARY_DNS)..."
    secondary_ping_time=$(ping -c 3 -W 1 $SECONDARY_DNS | grep "time" | awk '{print $7}')
    secondary_ping_time=${secondary_ping_time%ms}  # Remove "ms" from the end
    draw_progress_bar $secondary_ping_time
  fi
}

# Function to draw a simple progress bar
draw_progress_bar() {
  local ping_time="$1"
  local max_time=100  # Adjust this value as needed (higher for slower connections)
  local bar_length=40  # Adjust this value to control the bar length

  local progress=$((ping_time * 100 / max_time))
  local filled_chars=$((progress * bar_length / 100))
  local empty_chars=$((bar_length - filled_chars))

  # Create the progress bar
  printf "[%-${filled_chars}s%-${empty_chars}s] %s ms\n" "=" " " "$ping_time"
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
