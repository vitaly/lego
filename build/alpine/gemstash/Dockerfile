FROM ruby:alpine AS base

RUN apk --no-cache upgrade

RUN apk --no-cache add sqlite-libs

FROM base AS build

RUN apk --no-cache add build-base
RUN apk --no-cache add sqlite-dev

RUN gem install --no-ri --no-rdoc gemstash

FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle

EXPOSE 9292
VOLUME /root/.gemstash
CMD ["gemstash", "start", "--no-daemonize"]
