# Headers Demo for iOS
Demonstrates behavior with values of 'Cache-Control' and 'Etag" response headers on iOS.
For more info and explanations of how these response header values affect
your iOS apps, see [Use Your Headers](https://blog.diveinsoft.com/2024/04/for-on-device-caching-use-your-headers.html) and [Just in Time On-Device Caching with ETAG](https://blog.diveinsoft.com/2024/05/just-in-time-on-device-caching-with-etag.html)

See the blog post entries on how to perform the forensics on viewing cache data in the simulator.


## API Layer
The source code for the fake API is also located in Github, but is deployed to Google App Engine (see "urlBase" in the view model.)
The backend will frequently spin down to zero instances, so when executing the demo, allow a few seconds for the backend to launch.

### API Client
I've generated the classes in the `generated` folder using the [OpenAPI generator](https://github.com/OpenAPITools/openapi-generator), which accepts OpenAPI (formerly Swagger) documentation URLs and produces generated client code.
The command for generating these is ` openapi-generator generate -g swift5 --skip-validate-spec -i http://localhost:8080/v3/api-docs`.  You can also use the GAE-hosted version to generate these files.
For iOS, I've only used the model classes, since I wanted to demonstrate an extremely vanilla call to a REST API.

