
#!/usr/bin/env python3

import requests
import json
import time
import os
import sys
from datetime import datetime
import warnings
from urllib3.exceptions import InsecureRequestWarning

# Suppress only the InsecureRequestWarning
warnings.simplefilter("ignore", InsecureRequestWarning)
# Icinga2 API endpoint and credentials
ICINGA2_API_URL = os.getenv("ICINGA2_API_URL")
ICINGA2_API_USER = os.getenv("ICINGA2_API_USER")
ICINGA2_API_PASSWORD = os.getenv("ICINGA2_API_PASSWORD")

if not all([ICINGA2_API_USER, ICINGA2_API_PASSWORD, ICINGA2_API_URL]):
    print(json.dumps({
        "text": "󰀪 Not initialized",
        "tooltip": "Missing environment variables for Icinga2 API",
        "class": "icinga2-alerts"
    }))
    sys.exit(1)

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
            timeout=5
        )
        response_services = requests.get(
            f"{ICINGA2_API_URL}/objects/services",
            headers=HEADERS,
            auth=(ICINGA2_API_USER, ICINGA2_API_PASSWORD),
            verify=False,  # Set to True if using SSL certificate
            timeout=5
        )
        response_hosts.raise_for_status()
        response_services.raise_for_status()

        data_hosts = response_hosts.json()
        data_services = response_services.json()

        error_states = 0
        warning_states = 0
        details = []

        for service in data_services["results"]:
            state = service["attrs"]["state"]
            severity = ""
            if state == 2:
                error_states += 1
                severity = "Critical"
            elif state == 1:
                warning_states += 1
                severity = "Warning"

            if state in [1, 2]:
                details.append({
                    "name": service["name"],
                    "severity": severity,
                    "last_check": service["attrs"]["last_check_result"]["output"],
                })

        for host in data_hosts["results"]:
            state = host["attrs"]["state"]
            severity = ""
            if state == 2:
                error_states += 1
                severity = "Critical"
            elif state == 1:
                warning_states += 1
                severity = "Warning"

            if state in [1, 2]:
                details.append({
                    "name": host["name"],
                    "severity": severity,
                    "last_check": host["attrs"]["last_check_result"]["output"],
                })

        return error_states, warning_states, details

    except Exception as e:
        # Fallback when API is unreachable
        return None, None, str(e)


# Function to generate the Waybar JSON output
def generate_waybar_output(error_states, warning_states, details):
    if error_states is None and warning_states is None:
        # API unreachable case
        return {
            "text": "󰀪 Not initialized",
            "tooltip": f"Icinga2 API unreachable: {details}",
            "class": "icinga2-alerts"
        }

    text = f"󱗗 {error_states} 󰀪 {warning_states}"
    tooltip = ""
    for detail in details:
        tooltip += f"{detail['severity']}: {detail['name']} - {detail['last_check']}\n"

    return {
        "text": text,
        "tooltip": tooltip.strip(),
        "class": "icinga2-alerts" if error_states > 0 or warning_states > 0 else "",
    }


# Main loop to run as a daemon
def main():
    while True:
        error_states, warning_states, details = get_icinga2_alerts()
        output = generate_waybar_output(error_states, warning_states, details)
        print(json.dumps(output), flush=True)
        time.sleep(60)


if __name__ == "__main__":
    main()
