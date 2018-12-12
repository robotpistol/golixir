FROM quay.io/brex/elixir:1.7.3

ARG MIX_ENV=dev
ARG VERSION=untagged

COPY . /app
WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

RUN MIX_ENV=${MIX_ENV} mix deps.get && \
    MIX_ENV=${MIX_ENV} mix deps.compile && \
    MIX_ENV=${MIX_ENV} mix compile

LABEL org.elixir-lang.mix.env=${MIX_ENV}
LABEL version=${VERSION}
