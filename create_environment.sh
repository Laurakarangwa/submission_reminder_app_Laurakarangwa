#!/bin/bash

# Prompt for user's name
read -p "Enter your name: " username

# Define main directory
kara="submission_reminder_app_${username}"

# Create directory structure
mkdir -p "$kara/app"
mkdir -p "$kara/modules"
mkdir -p "$kara/assets"
mkdir -p "$kara/config"

# Create necessary files
touch "$kara/app/reminder.sh"
touch "$kara/modules/functions.sh"
touch "$kara/assets/submissions.txt"
touch "$kara/startup.sh"
touch "$kara/README.md"

# Works on config.env
cat << EOF > "$kara/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Works on submissions.txt with sample student records
cat << EOF > "$kara/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Laura, C programming, submitted
Kwizera, Python, not submitted
King, Data structure, submitted
Jonathan, Database, not submitted
Karangwa, Linux, submitted
EOF

# Work on functions.sh
cat << 'EOF' > "$kara/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# Populate reminder.sh
cat << 'EOF' > "$kara/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# Populate startup.sh
cat << 'EOF' > "$kara/startup.sh"
#!/bin/bash

# Load environment variables and functions
source ./config/config.env
source ./modules/functions.sh

# Path to submission file
submissions_file="./assets/submissions.txt"

# Check if submissions file exists
if [ ! -f "$submissions_file" ]; then
    echo "Error: Submissions file ($submissions_file) is missing!"
    exit 1
fi

# Display assignment details from the environment variables
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"

echo "----------------------------------------------"

# Call the function to check submissions
check_submissions "$submissions_file"

# Reminder executable message
echo "Reminder script executed successfully!"
EOF


# Make scripts executable
chmod +x "$kara/modules/functions.sh"
chmod +x "$kara/startup.sh"
chmod +x "$kara/app/reminder.sh"

echo "Environment setup completed! Run the application..."
cd "$kara"
./startup.sh 

