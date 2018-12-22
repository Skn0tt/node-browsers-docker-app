FROM node:9.11.2 AS build-env

COPY get-latest-version.js .
RUN node get-latest-version.js
RUN export VERSION=$(node get-latest-version.js); wget https://github.com/docker/app/releases/download/$VERSION/docker-app-linux.tar.gz

FROM circleci/node:10-browsers

COPY --from=build-env docker-app-linux.tar.gz .
RUN sudo tar xf docker-app-linux.tar.gz
RUN sudo cp docker-app-linux /usr/local/bin/docker-app
RUN sudo rm docker-app-linux docker-app-linux.tar.gz
