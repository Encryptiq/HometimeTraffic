# Hometime Traffic

A traffic generator script for simulating web traffic on specified domains. Useful for penetration testing and blending in with normal traffic.

## Usage

### Prerequisites

- Windows operating system
- PowerShell

### Installation

1. Clone this repository:

    ```bash
    git clone https://github.com/encryptiq/hometime_traffic.git
    ```

2. Navigate to the cloned directory:

    ```bash
    cd hometime_traffic
    ```

### Running the Script

1. Open PowerShell.
2. Navigate to the directory where the script is located.
3. Run the script with the following command:

    ```bash
    ./hometime_traffic.ps1 -Domain https://example.com
    ```

   Replace `https://example.com` with the domain you want to generate traffic for.

## Description

The Hometime Traffic script simulates web traffic on a specified domain. It utilizes a list of user agents to mimic different devices and browsers. This can be helpful during penetration testing to avoid detection or to analyze a website's performance under different traffic conditions.

The script continuously sends requests to random URLs within the specified domain using randomly selected user agents. This helps create a more realistic traffic pattern that blends in with regular user activity.

## Script Details

### Parameters

- **Domain**: The target domain to generate traffic for.

### Functions

1. **extract_wordlist**: Extracts URLs from the specified domain.
2. **send_random_request**: Sends a request to a random URL within the domain using a random user agent.

### Banner

The script starts with a banner displaying the project name and a custom ASCII art.

## Acknowledgments

- This script is developed by [encryptiq](https://github.com/encryptiq).