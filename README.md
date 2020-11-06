# productive

## Rationale

This is a short Haskell script whose purpose is to disable or re-enable social networks.
The idea behind this is not to get too distracted during work hours.

## Usage

`stack build` : builds the executable
`sudo ./productive-exe 0` disables productivity mode (enables social network access)
`sudo ./productive-exe 1` enables productivity mode (disables social network access)

You need administrator rights because the script edits the `/etc/hosts` file on your machine.

