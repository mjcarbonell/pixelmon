#!/bin/sh

# Email settings
RECIPIENT="maximcarbonell@gmail.com"
SUBJECT="Just Saying Hey!"
MESSAGE="Hey!"

# Send the email
echo "$MESSAGE" | mail -s "$SUBJECT" $RECIPIENT
