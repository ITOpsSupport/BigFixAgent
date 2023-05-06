#!/bin/bash
#created by: raj.ayush@naukri.com
#Last modified: 6 May 2023

# Check if IPv6 is already disabled
if grep -qxF 'net.ipv6.conf.all.disable_ipv6 = 1' /etc/sysctl.conf &&
   grep -qxF 'net.ipv6.conf.default.disable_ipv6 = 1' /etc/sysctl.conf &&
   grep -qxF 'net.ipv6.conf.lo.disable_ipv6 = 1' /etc/sysctl.conf
then
    echo "IPv6 is already disabled."
else
    # Disable IPv6
    echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf

    # Apply the changes
    sudo sysctl -p

    echo "IPv6 has been disabled."
fi

# Define package name
PACKAGE_NAME=BESAgent-10.0.9.21-ubuntu10.amd64.deb

# Check if package is installed
if dpkg -s $PACKAGE_NAME >/dev/null 2>&1; then
    echo "$PACKAGE_NAME is already installed."
else
    # Make directory
    mkdir -p /etc/opt/BESClient
    cp actionsite.afxm /etc/opt/BESClient

    # Install package
    sudo dpkg -i $PACKAGE_NAME

    # Remove package file
    rm $PACKAGE_NAME

    echo "$PACKAGE_NAME has been installed."
fi

# Start BESAgent service
sudo /etc/init.d/besclient start
