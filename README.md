# WordPress PHP container with New Relic PHP agent

A usable Docker container with 
- WordPress
- PHP FPM 
- Memcached Library
- New Relic PHP agent

## Prerequisite
There is no MySQL container provided in this example, this is assumed that MySQL is running

## Setup
1. Clone this repo

2. Modify docker-compose.yml file if required

3. Make a copy of .env from .env-example
```
$ cp .env-example .env
```

4. Modify .env to suit

5. Deploy the container and daemonise with Docker Compose
```
docker-compose up -d
```

## New Relic App Name
Drop `.user.ini` into the doc root, see example
```
$ cat .user.ini 
newrelic.appname = "Default"
```

## References
- [Install the PHP agent with Docker](https://bit.ly/2Z7jQNj)
- [PHP per-directory INI settings](https://bit.ly/2M9cHbp)
