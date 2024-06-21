#!/bin/sh

# Script title and information
echo "=========================================================================="
echo "   SWDNS - Smart DNS Changer v1.4   "
echo "=========================================================================="
echo "Copyright (c) 2023 Claxpoint. All rights reserved."
echo "https://github.com/claxpoint"
echo "=========================================================================="

# Define Iranian and global DNS servers (replace with your preferred list)
iranian_dns_servers=(
  "8.8.8.8"  # Google (Global) - Placeholder for reference
  "1.1.1.1"  # Cloudflare (Global) - Placeholder for reference
  "194.225.73.141"  # Iran (persia.iranet.ir) - Example
  "91.99.101.12"    # Iran (parsonline.net) - Example
)
global_dns_servers=(
  "8.8.8.8"  # Google (Global)
  "1.1.1.1"  # Cloudflare (Global)
  "208.67.222.222"  # OpenDNS (Global)
  "9.9.9.9"   # Quad9 (Global)
)

# Function to display the main menu
display_menu() {
  echo "
  1. **Set DNS to localhost (127.0.0.1)**
  2. Manual Set
  3. Auto u3switcher Scan
  4. Test DNS Servers (Iranian & Global)
  5. Reset To Default resolv.conf
  6. Exit

  Enter choice [1-6]: "
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
    echo "nameserver <span class="math-inline">secondary\_dns\_server" \| sudo tee \-a /etc/resolv\.conf
fi
echo "DNS servers set successfully\."
\}
\# Function to reset DNS to default
reset\_dns\(\) \{
echo "Resetting DNS to default\.\.\."
sudo mv /etc/resolv\.conf\.bak /etc/resolv\.conf
echo "DNS reset to default successfully\."
\}
\# Function to test DNS servers \(informational, doesn't switch automatically\)
test\_dns\_servers\(\) \{
echo "\*\* Testing DNS Servers \(Iranian & Global\) \*\*"
echo "\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\="
\# Test Iranian DNS servers
echo "\*\* Iranian Servers \*\*"
fastest\_server\=""
fastest\_ping\_time\=9999  \# Initialize with a high value
for server in "</span>{iranian_dns_servers[@]}"; do
    ping_time=$(ping -c 3 -W 1 $server | grep "time" | awk '{print <span class="math-inline">7\}'\)
ping\_time\=</span>{ping_time%ms}  # Remove "ms" from the end

    echo "  - $server: $ping_time ms"

    if [[ $ping_time -lt $fastest_ping_time ]]; then
      fastest_server=$server
      fastest_ping_time=<span class="math-inline">ping\_time
fi
done
\# Test global DNS servers
echo "\*\* Global Servers \*\*"
for server in "</span>{global_dns_servers[@]}"; do
    ping_time=$(ping -c 3 -W 1 $server | grep "time" | awk '{print <span class="math-inline">7\}'\)
ping\_time\=</span>{ping_time%ms}  # Remove "ms" from the end
    echo "  - $server: $
