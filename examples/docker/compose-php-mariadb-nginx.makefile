projectName:="myPhpProject"

up:
  docker-compose \
    -p $(projectName) \
    -f docker-compose.yml \
    up --build -d --remove-orphans --force-recreate
start:
  docker-compose \
    -p $(projectName) \
    -f docker-compose.yml \
    start
stop:
  docker-compose \
    -p $(projectName) \
    -f docker-compose.yml \
    stop
down:
  docker-compose \
    -p $(projectName) \
    -f docker-compose.yml \
    down
init:
  docker exec -it $(projectName)_php_1 composer install
install: up init
php-shell:
  docker exec -it $(projectName)_php_1 sh
