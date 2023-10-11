FROM alpine:latest AS alpine_based
RUN apk add --update nodejs npm

FROM debian:latest AS debian_based
RUN apt-get update && apt-get install -y curl

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs
RUN node -v
RUN npm -v
COPY --from=alpine_based / /alpine-root

WORKDIR /app
COPY . /app
RUN npm install
EXPOSE 3001
CMD node index.js
