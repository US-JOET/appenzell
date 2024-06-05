# Appenzell

noun - [ˈapn̩ˌt͡sɛl]

1. A command-line tool for driving OCPP Profiles through an OCPP 2.0 system.
2. The Swiss canton that existed 1403 to 1597 that is the location of the earliest known yodel, which happened in 1545. It is described as "the call of a cowherd from Appenzell." - [source](https://en.wikipedia.org/wiki/Yodeling#History_of_Alpine_yodeling)

## Setup

You will need [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed on your system. You should
then see something like this:

```bash
$> docker -v 
Docker version 26.1.1, build 4cf5afa
```

You will then need to authenticate Docker with GitHub using a
[personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens):

```bash
$> docker login ghcr.io
Username: [YOUR_GITHUB_USERNAME] 
Password: [YOUR_GITHUB_ACCESS_TOKEN] 
```

## Running

The script `run-demo.sh` is used locally on the host to run the demo.
When running the script will check for a local image of `ghcr.io/us-joet/appenzell:latest`.
If there is not it will pull it in locally.

There are two flags

```txt
    `-i` - required input directory of json charging profiles
    `-o` - optional output directory for the generated composite schedule.
```

You can create a directory on your host with the needed charging profile json files.
If you would like to save the composite schedule output json to the host you can use the optional output directory.

For example:

```bash
$> export APPENZELL_HOME="${HOME}/src/github.com/US-JOET/appenzell"
$> ./run-demo.sh -i "${APPENZELL_HOME}/scenarios/case_one/" -o "${APPENZELL_HOME}/output/"
...
composite_schedule: {
    "chargingRateUnit": "W",
    "chargingSchedulePeriod": [
        {
            "limit": 2000.0,
            "numberPhases": 1,
            "startPeriod": 0
        },
        {
            "limit": 11000.0,
            "numberPhases": 3,
            "startPeriod": 1020
        },
        {
            "limit": 6000.0,
            "numberPhases": 3,
            "startPeriod": 25140
        }
    ],
    "duration": 43140,
    "evseId": 1,
    "scheduleStart": "2024-01-17T18:01:00.000Z"
}
input_directory: /input/
output_directory:  /output/
```

## Current charin_demo under the hood

This docker image is using https://github.com/US-JOET/libocpp.git on branch `charin-demo`

As part of the branch we build a test cli command that is accessiable in `<workspace>/build/tests`

You can then run the command `./charin_demo_bin`

This has the options:
- --help
- --input-dir  - required directory that contains the profile json files
- --output-dir - optional directory to output the composite schedule json file

## Docker

You can build a version of the docker container locally if desired. To do so run the command
`docker build  --platform linux/x86_64 -t ghcr.io/us-joet/appenzell:latest .` 

This can be used to change the git branch that is used internally for composite schedule generation.

