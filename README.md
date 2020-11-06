# productive

## Rationale

This is a short Haskell script whose purpose is to disable or re-enable social networks.
The idea behind this is not to get too distracted during work hours.

## Usage

Use `stack build` to build the executable, then `sudo ./productive-exe 1` to enable social networks
and `sudo ./productive-exe 0` to disable them.
You need administrator rights because the script edits the `/etc/hosts` file on your machine.

