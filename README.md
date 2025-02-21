# Submission Reminder App

The **Submission Reminder App** helps students stay on track with their assignments by sending reminders and tracking deadlines. It allows users to set due dates, receive notifications, and organize their tasks with a calendar. This ensures they never miss a submission and can manage their workload more easily.

## Setup Instructions to follow:

1. Run the setup script

   Clone repository: 
   ```
   git clone https://github.com/Laurakarangwa/submission_reminder_app_Laurakarangwa.git
   ```

2. Navigate to the created directory and start the app:
   ```
   cd submission_reminder_${userName}/scripts
   chmod +x startup.sh
   ./startup.sh
   ```

## Project Structure:
- `reminder.sh` → Runs the actual reminder logic.
- `functions.sh` → Contains core utility functions that applications uses.
- `submissions.txt` → Contains data about the students submissions that the app is monitoring.
- `config.env` → Hold configuration settings of the application.
- `startup.sh` → Initializes and starts the application.

## Author:
Developed by **Laurakarangwa**
