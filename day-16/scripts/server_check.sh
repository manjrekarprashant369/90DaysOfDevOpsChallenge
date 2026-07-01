#!/bin/bash

SERVICE="nginx"

read -p "Do you want to check the status of $SERVICE? (y/n): " ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then

	if systemctl is-active --quiet "$SERVICE"; then
		echo "$SERVICE service is ACTIVE."
	else
		echo "$SERVICE service is NOT ACTIVE."
	fi
elif [[ "$ANSWER" == "n" || "$ANSWER" == "N" ]]; then
	echo "Skipped"
else
	echo "Invalid input. Plese enter y or n."
fi
