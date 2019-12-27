## FIX validator service

Docker image to run [fix-validator](https://github.com/whoan/fix-validator) as a service. It uses [servify](https://github.com/whoan/servify) under the hood, to get the command into a service.

### Usage

- Run the docker image exposing port 4000:

    ```bash
    docker run -ti --rm -p "4000:4000" docker.pkg.github.com/whoan/fix-validator-service/fix-validator-service:buster-slim
    ```

- Make a POST request with a FIX schema as the data value (in base64) of the JSON payload:

    ```bash
    curl -H "Content-Type: application/json" http://0.0.0.0:4000/ -d"{\"data\": \"$(base64 -w0 your_schema.xml)\"}"
    ```

### Example

```bash
curl -H "Content-Type: application/json" http://0.0.0.0:4000/ -d"{\"data\": \"$(base64 -w0 ~/my_schema.xml)\"}"
```
```json
{"status":1,"stderr":"Configuration failed: Field named MyField defined multiple times\n","stdout":""}
```

### Using public service

```bash
curl -k -H "Content-Type: application/json" https://fix-validator.whoan.me/ -d"{\"data\": \"$(base64 -w0 your_schema.xml)\"}"
```

### Create a handy command to verify schemas

```bash
fixv() {
  local schema
  schema="${1:?PLease provide a FIX schema file to validate}"
  curl -k -H "Content-Type: application/json" https://fix-validator.whoan.me/ -d"{\"data\": \"$(base64 -w0 "$schema")\"}"
}
```
