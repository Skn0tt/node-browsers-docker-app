FROM node:9.11.2 AS build-env

COPY get-latest-version.js .
RUN node get-latest-version.js
RUN export VERSION=$(node get-latest-version.js); wget https://github.com/docker/app/releases/download/$VERSION/docker-app-linux.tar.gz

FROM circleci/node:9-browsers

COPY --from=build-env docker-app-linux.tar.gz .
RUN tar xf docker-app-linux.tar.gz
RUN rm docker-app-linux.tar.gz
RUN cp docker-app-linux /usr/local/bin/docker-app
RUN rm docker-app-linux
