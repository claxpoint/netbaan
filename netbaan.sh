#!/bin/sh

# Define your desired primary and secondary DNS servers (replace with your choices)
PRIMARY_DNS="8.8.8.8"
SECONDARY_DNS="8.8.4.4"

# Backup the original resolv.conf (optional, but recommended for safety)
cp /etc/resolv.conf /etc/resolv.conf.bak

# Clear the existing contents of /etc/resolv.conf (important)
echo "" > /etc/resolv.conf  # Alternatively: `truncate -s 0 /etc/resolv.conf`

# Add the primary and secondary DNS servers
echo "nameserver $PRIMARY_DNS" >> /etc/resolv.conf
echo "nameserver $SECONDARY_DNS" >> /etc/resolv.conf

echo "DNS settings changed to: $PRIMARY_DNS and $SECONDARY_DNS"
