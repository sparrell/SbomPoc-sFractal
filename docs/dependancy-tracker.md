# Dependancy track
Dependency-Track is an intelligent Software Supply Chain Component Analysis platform
that allows organizations to identify and reduce risk from the use of third-party and open source components

## Deployment of the tracker to a virtual machine
Owasp provides a [docker image](https://hub.docker.com/r/owasp/dependency-track) that can be used to do deploy the application on to a virtual machine.

1. Create a virtual machine with the following specifications:

      | Minimum     | Recommended |
      |-------------|-------------|
      | 4.5GB RAM   | 16GB RAM    |
      | 2 CPU cores | 4 CPU cores |

2. SSH into the virtual machine created
3. Install docker and ensure its running
4. run the following commands in sequence to start the tracker

```shell
docker pull owasp/dependency-track
docker volume create --name dependency-track
docker run -d -m 8192m -p 8080:8080 --name dependency-track -v dependency-track:/data owasp/dependency-track
```
## Running on your local machine
It is possible to run the tracker on your local computer but you should note that it requires a significant resources as listed above.
If you have docker running your computer, run the commands on step 4 above to get the tracker running

## Troubleshooting
The commands above have been picked directly from   [owasp docker image page](https://hub.docker.com/r/owasp/dependency-track) so if you
are having trouble, visit that page to ensure the commands and requirements above are not outdated
