#!/bin/bash

# Check if .gitconfig exists and if it contains name and email
gitconfig_path="$HOME/.gitconfig"
name_empty=true
email_empty=true

if [ -f "$gitconfig_path" ]; then
    if grep -q "name =" "$gitconfig_path"; then
        name_empty=false
    fi
    if grep -q "email =" "$gitconfig_path"; then
        email_empty=false
    fi
fi

# Prompt only if both name and email are empty
if $name_empty || $email_empty; then
    read -p "Git configuration .gitconfig is empty. Do you want to set up it? (y/n): " setup_git
    if [[ $setup_git != "y" ]]; then
        echo "Git setup skipped."
        exit 0
    fi

    # Prompt for user input
    read -p "Enter your Git username: " git_username
    read -p "Enter your Git email: " git_email

    # Prompt for credential helper
    echo "Choose a credential helper:"
    echo "1) osxkeychain (for macOS)"
    echo "2) cache (temporary storage in memory)"
    echo "3) store (stores credentials in plaintext file)"
    echo "4) None (don't use a credential helper)"
    read -p "Enter your choice (1-4): " helper_choice

    case $helper_choice in
        1) credential_helper="osxkeychain" ;;
        2) credential_helper="cache" ;;
        3) credential_helper="store" ;;
        4) credential_helper="" ;;
        *) echo "Invalid choice. No credential helper will be set."; credential_helper="" ;;
    esac

    # Update .gitconfig file
    {
        echo "[user]"
        echo "	name = $git_username"
        echo "	email = $git_email"
        if [ -n "$credential_helper" ]; then
            echo "[credential]"
            echo "	helper = $credential_helper"
        fi
    } > "$gitconfig_path"

    echo "Git configuration updated successfully."
else
    echo "Git configuration already contains name and email. No need to prompt."
fi
