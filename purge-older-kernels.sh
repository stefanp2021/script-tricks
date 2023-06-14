#!/bin/bash

################################################################################
# Script: purge_kernel.sh
# Author: [Your Name]
# Date: [Current Date]
# Description: This script purges unnecessary Linux kernel images and headers
#              from the system, excluding the currently running kernel. It
#              helps free up disk space by removing unused kernel packages.
################################################################################


# Get the currently running kernel version
running_kernel=$(uname -r)

# Purge unnecessary Linux kernel images
sudo apt purge $(
    # List installed Linux kernel images, discard errors, and extract package names
    sudo apt list --installed linux-image* 2>/dev/null |
    grep "linux-image-*" |
    grep -v "$running_kernel" |
    cut -d/ -f1
) $(
    # List installed Linux kernel headers, discard errors, and extract package names
    sudo apt list --installed linux-headers* 2>/dev/null |
    grep "linux-headers-*" |
    grep -v "$running_kernel" |
    cut -d/ -f1
)
