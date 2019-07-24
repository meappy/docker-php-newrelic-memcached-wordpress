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

The container will be up and running at http://localhost:8080 and will display the PHP Info page.

## References
- [Install the PHP agent with Docker](https://bit.ly/2Z7jQNj)
