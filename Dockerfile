# heavily borrowed from https://elixirforum.com/t/cannot-find-libtinfo-so-6-when-launching-elixir-app/24101/11?u=sigu
FROM  hexpm/elixir:1.11.2-erlang-22.3-debian-buster-20200224  AS app_builder

ARG env=prod

ENV LANG=C.UTF-8 \
   TERM=xterm \
   MIX_ENV=$env

RUN mkdir /opt/release
WORKDIR /opt/release

RUN mix local.hex --force && mix local.rebar --force

COPY mix.exs .
COPY mix.lock .
RUN apt-get update && apt-get install curl make  gcc -y 
RUN mix deps.get && mix deps.compile

# Let's make sure we have node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Compile assets
COPY assets ./assets
RUN npm install --prefix ./assets && \
     npm run deploy --prefix ./assets

# Now, let's go with the actual elixir code. The order matters: if we only
# change elixir code, all the above layers will be cached ~ less image build time.
COPY config ./config
COPY lib ./lib
COPY priv ./priv

# Final build step: digest static assets and generate the release
RUN mix phx.digest && mix release

FROM debian:buster-slim AS app

ARG CLIENT_ID=:sbompoc
ARG MQTT_HOST=34.86.117.113
ARG MQTT_PORT=1883
ARG USER_NAME=plug
ARG PASSWORD=fest


ENV LANG=C.UTF-8
ENV CLIENT_ID=$CLIENT_ID
ENV MQTT_HOST=$CLIENT_ID
ENV MQTT_PORT=$MQTT_PORT
ENV USER_NAME=$USER_NAME
ENV PASSWORD=$PASSWORD

RUN apt-get update && apt-get install -y openssl

RUN useradd --create-home app
WORKDIR /home/app
COPY --from=app_builder /opt/release/_build .
RUN chown -R app: ./prod
USER app

CMD ["./prod/rel/sbom_poc/bin/sbom_poc", "start"]
