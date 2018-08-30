FROM node:alpine

RUN apk --no-cache upgrade

RUN yarn global add npm-proxy-cache

EXPOSE 8080
VOLUME '/data'
CMD ['npm-proxy-cache', '-h', '0.0.0.0', '-s', '/data', '-t', '31536000']
