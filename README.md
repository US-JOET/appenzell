# appenzell

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

