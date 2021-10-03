projectDir:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
projectName:="myPhpProject"

phpImageName:="php"
phpImageVersion:="alpine-7.4"
phpImageTag:="$(imageName):$(imageVersion)"
# phpunit + coverage clover + coverage html + junit
phpTestCmd:="vendor/bin/phpunit \
  --testdox \
  --coverage-html \
  $(projectDir)/build/logs/coverage \
  --coverage-clover \
  $(projectDir)/build/logs/clover.xml \
  --log-junit \
  $(projectDir)/build/logs/junit.xml"

# pull your image
pull-php:
  docker pull $(phpImageTag)
# build your image
build-php:
  docker build $(phpImageTag) -t $(projectName) .
# install dependencies
vendor/:
  docker run --mount src=$(projectDir),target=/app,type=bind --rm sh -c "composer install && chmod 777 vendor/ -R"
init-php: vendor/
# perform all needed task for installation
install-php: pull-php build-php init-php
# run a command in you container
test-php: vendor/
  docker run --mount src=$(projectDir),target=/app,type=bind --rm $(phpTestCmd)
