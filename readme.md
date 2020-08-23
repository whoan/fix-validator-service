## FIX validator service

Docker image to run [fix-validator](https://github.com/whoan/fix-validator) as a service. It uses [servify](https://github.com/whoan/servify) under the hood, to get the command into a service.

### Run it locally

- Run the docker image exposing port 8080:

  ```bash
  docker run -ti --rm -p "8080:8080" docker.pkg.github.com/whoan/fix-validator-service/fix-validator-service:buster-slim
  ```

- Make a POST request with a FIX schema as the data value (in base64) of the JSON payload:

  ```bash
  curl -H "Content-Type: application/json" http://0.0.0.0:8080/ -d"{\"data\": \"$(base64 -w0 your_schema.xml)\"}"
  ```

- Get a success|error response:

  ```json
  {"status":1,"stderr":"Configuration failed: Field named MyField defined multiple times\n","stdout":""}
  ```

### Use public service

```bash
curl -k -H "Content-Type: application/json" https://fix-validator.whoan.online/ -d"{\"data\": \"$(base64 -w0 your_schema.xml)\"}"
```

### Create a handy command to verify schemas

```bash
fixv() {
  local schema
  schema="${1:?PLease provide a FIX schema file to validate}"
  curl -k -H "Content-Type: application/json" https://fix-validator.whoan.online/ -d"{\"data\": \"$(base64 -w0 "$schema")\"}"
}
```

## License

[MIT](https://github.com/whoan/fix-validator-service/blob/master/LICENSE)
