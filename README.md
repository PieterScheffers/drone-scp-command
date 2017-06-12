# drone-scp-command

## Usage

Execute from the working directory:

```
docker run --rm \
  -e PLUGIN_KEY="$(cat ~/.ssh/id_rsa)" \
  -e PLUGIN_PORT=22 \
  -e PLUGIN_SOURCE=my_local_file \
  -e PLUGIN_TARGET=myuser@somehost:/path/to/remote \
  -e PLUGIN_RECURSIVE=true \
  -e PLUGIN_COMPRESSION=true \
  -e PLUGIN_PRESERVE_TIMESTAMPS=true \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  pieterscheffers/drone-scp-command
```
