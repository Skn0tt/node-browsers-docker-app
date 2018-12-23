FROM busybox AS build-env

RUN wget https://github.com/docker/app/releases/download/v0.6.0/docker-app-linux.tar.gz

FROM circleci/node:10-browsers

COPY --from=build-env docker-app-linux.tar.gz .
RUN sudo tar xf docker-app-linux.tar.gz
RUN sudo cp docker-app-linux /usr/local/bin/docker-app
RUN sudo rm docker-app-linux docker-app-linux.tar.gz
