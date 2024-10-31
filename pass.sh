#!/bin/bash

# Simple Password Manager
echo "Welcome to the Simple Password Generator"

# File to store all passwords
PASSWORD_FILE="pass.txt"

# Function to generate a password
generate_password() {
    local length=$1
    local char_set=$2
    echo $(< /dev/urandom tr -dc "$char_set" | head -c "$length")
}

# Function to save password
save_password() {
    local password=$1
    echo "$password" >> "$PASSWORD_FILE"
}

# Main loop for password generation
while true; do
    # Ask for the number of passwords to generate
    read -p "How many passwords do you want to generate? (e.g., 20, 50) or 0 to exit: " num_passwords
    
    # Exit if user inputs 0
    if [[ "$num_passwords" -eq 0 ]]; then
        echo "Exiting. Goodbye!"
        exit 0
    fi

    # Validate input
    if ! [[ "$num_passwords" =~ ^[0-9]+$ ]] || [ "$num_passwords" -le 0 ]; then
        echo "Please enter a valid positive integer."
        continue
    fi

    # Generate passwords
    for ((i=1; i<=num_passwords; i++)); do
        # Generate a random length between 8 and 16
        length=$((RANDOM % 9 + 8))  # Random length from 8 to 16
        
        # Define character set for the password
        char_set="A-Za-z0-9!@#$%^&*()-_+=<>?"
        
        # Generate the password
        password=$(generate_password "$length" "$char_set")
        
        # Save password
        save_password "$password"
    done
    
    echo "$num_passwords passwords generated and saved to $PASSWORD_FILE."
done
