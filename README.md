# WordPress PHP container with New Relic PHP agent

A usable Docker container with 
- WordPress
- PHP FPM 
- Memcached library (libmemcached)
- PHP Redis
- New Relic PHP agent

## Prerequisite
- There is no MySQL container supplied in this example, this is assumed that MySQL is running for WordPress to operate
- If no New Relic license key is supploied, the container will not be built with New Relic PHP agent. You can choose to not have New
  Relic built. Simply remove NR_LICENSE_KEY in .env file.

## Setup
1. Clone this repo

2. Make a copy of .env from .env-example
```
$ cp .env-example .env
```

3. Modify .env to suit

4. An example Docker Compose file is included, deploy & daemonise the container with the included Docker Compose file.
   In most cases, this is not necessary, however modify docker-compose.yml file if required
```
docker-compose up -d
```

## New Relic App Name
There are 2 methods for naming the app in New Relic. 
- NR_APP_NAME variable in .env
- .user.ini file in the doc root of the web app

I prefer to leave NR_APP_NAME intact and dropping `.user.ini` into the doc root, see example
```
$ cat .user.ini 
newrelic.appname = "Default"
```

## References
- [Install the PHP agent with Docker](https://bit.ly/2Z7jQNj)
- [PHP per-directory INI settings](https://bit.ly/2M9cHbp)
