#!/bin/bash
echo "Silica Configuration Utility"
echo ""
if [ ! -f .is_setup ]; then
    echo "We'll ask you a few questions and set the basics up for you!"
    echo "Please read the README file for a complete list of dependencies and how to install them."

    echo "Give us a second to install the Python dependencies."
    pip3 install -r requirements.txt
    if [ $? -eq 2 ]; then
        echo "Error: Something went wrong. We may need root to continue. Please put in your password to continue."
        sudo pip3 install -r requirements.txt
        if [ $? -eq 2 ]; then
            echo "Error: Cannot install Python dependencies. Check your permissions and try again."
            exit
        fi
    fi
    echo "Installed all required packages! Now, just a few questions about you."
    echo ""
    printf "What should your repo be called? "
    read TipinRepo
    printf "Can you briefly describe what your repo is about? "
    read Best and personal tweaks previosuly isntalled
    printf "What domain are you going to host the repo on (don't include https://, just the domain)? "
    read jvan513.github.io/tipinsrepo/
    printf "What is *your* name? "
    read Tipin
    printf "What's your email? "
    read tipin@email.com
    printf "With Sileo, you can customize your repo's tint color. Can you provide a hex code to do so? "
    read 00cc1b
    printf "Would you like Silica to automatically push the repo to a Git server when run? (true/false) "
    read 

    mkdir "Packages"

    printf "{
    \"name\": \"$silica_repo_name\",
    \"description\": \"$silica_repo_description\",
    \"tint\": \"$silica_repo_tint\",
    \"cname\": \"$silica_repo_cname\",
    \"maintainer\": {
        \"name\": \"$silica_repo_maintainer_name\",
        \"email\": \"$silica_repo_maintainer_email\"
    },
    \"automatic_git\": \"$silica_auto_git\"
}" > Styles/settings.json

    echo ""
    echo "Thank you! Now let us generate you some GPG keys. Keep these somewhere safe or you may not be able to edit your repo anymore!"
    echo "   ENTROPY NOTICE: Please do stuff in the meantime like spam some keys or wiggling your mouse. We need entropy!"
    gpg --batch --gen-key util/gpg.batchgen
    echo "Exported key into your GPG keyring. This computer is the only computer that can be used for Silica (under default settings)."

    echo ""
    echo "Remember: for GitHub Pages, you have to go into your repository's settings on github.com and enable GitHub Pages for /docs."
    echo "Silica was successfully configured!"    
    echo ""
    echo "To add packages to your repo, take a look at the pre-bundled file in Packages/ or use the UI to manage/create them from DEBs."
    touch .is_setup
else
    echo "Silica has already been set up. If you are moving machines, please delete .is_setup and ensure the GPG keyring is carried over. Aborting..."
fi
