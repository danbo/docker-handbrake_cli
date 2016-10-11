# docker-handbrake_cli
Docker image of manual compilation of HandBrakeCLI

## Build
```bash
docker build -t danbo/handbrake -f Dockerfile .
```

##### Note
To add fdk_aac support, add --enable-fdk-aac to the configure line.

## Verify
```bash
docker run --rm danbo/handbrake /usr/local/bin/HandBrakeCLI --version
```

## Help
```bash
docker run --rm danbo/handbrake /usr/local/bin/HandBrakeCLI --help
```

## Run
```bash
encode.sh /full/path/to/input.file /full/path/to/output.file
```
##### Note
Encode log is produced beside the output file: ```/full/path/to/output.file.log```