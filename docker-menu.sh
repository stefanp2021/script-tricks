#!/bin/bash

# Define the base path for scripts
BASE_PATH="/home/user/docker/dockerswarm"

# Function to display the menu options
show_menu() {
    clear
    echo "===== Manage Docker Containers ====="
    echo "1. Start Traefik Container Stack"
    echo "2. Start Portainer Container Stack"
    echo "3. Start Vaultwarden Container Stack"
    echo "4. Start Asset Management Snipe-IT"
    echo "5. Start Traefik, Portainer, Vaultwarden in Order" # Changed to 5
    echo "6. Exit" # Changed to 6
    echo "================"
}

# Function to execute the selected script
execute_script() {
    local script_path

    case $1 in
        1) script_path="$BASE_PATH/traefik/deploy-traefik.sh" ;;
        2) script_path="$BASE_PATH/portainer/deploy-portainer-stack.sh" ;;
        3) script_path="$BASE_PATH/vaultwarden/deploy-vaultwarden.sh" ;;
        4) script_path="/home/user/docker/startup-scripts/start-snipeit-v2.sh" ;;
        5) # Changed to 5
            echo "Starting Traefik, Portainer, Vaultwarden in order..."
            execute_script 1
            execute_script 2
            execute_script 3
            return
            ;;
        6) # Changed to 6
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            return
            ;;
    esac

    # Check if the script exists and is executable
    if [ -x "$script_path" ]; then
        $script_path
    else
        echo "Error: Script $script_path does not exist or is not executable."
    fi
}

# Main menu loop
while true; do
    show_menu

    # Read user input
    read -p "Enter your choice: " choice

    # Execute the selected script based on the choice
    execute_script "$choice"

    # Wait for user to press Enter before clearing the screen
    read -p "Press Enter to continue..."
done
