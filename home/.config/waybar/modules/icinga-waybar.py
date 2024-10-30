#!/usr/bin/env python3

import requests
import json
import time
from datetime import datetime
import os

# Icinga2 API endpoint and credentials
ICINGA2_API_URL = os.getenv("ICINGA2_API_URL")
ICINGA2_API_USER = os.getenv("ICINGA2_API_USER")
ICINGA2_API_PASSWORD = os.getenv("ICINGA2_API_PASSWORD")

# Headers for the API request
HEADERS = {
    "Accept": "application/json",
    "X-HTTP-Method-Override": "GET",
}


# Function to get alerts from Icinga2 API
def get_icinga2_alerts():
    try:
        response_hosts = requests.get(
            f"{ICINGA2_API_URL}/objects/hosts",
            headers=HEADERS,
            auth=(ICINGA2_API_USER, ICINGA2_API_PASSWORD),
            verify=False,  # Set to True if using SSL certificate
        )
        response_services = requests.get(
            f"{ICINGA2_API_URL}/objects/services",
            headers=HEADERS,
            auth=(ICINGA2_API_USER, ICINGA2_API_PASSWORD),
            verify=False,  # Set to True if using SSL certificate
        )
        response_hosts.raise_for_status()  # Will raise an HTTPError for bad requests (4XX, 5XX)
        response_services.raise_for_status()

        data_hosts = response_hosts.json()
        data_services = response_services.json()

        error_states = 0
        warning_states = 0
        details = []

        for service in data_services["results"]:
            state = service["attrs"]["state"]
            severity = ""
            if state == 2:  # Critical/Error
                error_states += 1
                severity = "Critical"
            elif state == 1:  # Warning
                warning_states += 1
                severity = "Warning"

            if state in [1, 2]:  # If it's either warning or error
                details.append(
                    {
                        "name": service["name"],
                        "severity": severity,
                        "last_check": service["attrs"]["last_check_result"]["output"],
                    }
                )

        for host in data_hosts["results"]:
            state = host["attrs"]["state"]
            severity = ""
            if state == 2:  # Critical/Error
                error_states += 1
                severity = "Critical"
            elif state == 1:  # Warning
                warning_states += 1
                severity = "Warning"

            if state in [1, 2]:  # If it's either warning or error
                details.append(
                    {
                        "name": host["name"],
                        "severity": severity,
                        "last_check": host["attrs"]["last_check_result"]["output"],
                    }
                )

        return error_states, warning_states, details

    except Exception as e:
        print(f"Error fetching alerts: {e}")
        return 0, 0, []


# Function to generate the Waybar JSON output
def generate_waybar_output(error_states, warning_states, details):
    # Main display with the amount of error and warning states
    text = f"󱗗 {error_states} 󰀪 {warning_states}"

    # Tooltip details
    tooltip = ""
    for detail in details:
        tooltip += f"{detail['severity']}: {detail['name']} - {detail['last_check']}\n"

    # Build the JSON output for Waybar
    output = {
        "text": text,
        "tooltip": tooltip.strip(),
        "class": "icinga2-alerts" if error_states > 0 or warning_states > 0 else "",
    }
    return output


# Main loop to run as a daemon
def main():
    while True:
        error_states, warning_states, details = get_icinga2_alerts()
        output = generate_waybar_output(error_states, warning_states, details)

        # Print the output as JSON (Waybar reads this as input)
        print(json.dumps(output), flush=True)

        # Sleep for a period before checking again (e.g., 60 seconds)
        time.sleep(60)


if __name__ == "__main__":
    main()
