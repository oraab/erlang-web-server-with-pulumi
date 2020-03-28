FROM erlang:alpine

RUN mkdir /buildroot
WORKDIR /buildroot

COPY app demo_web_server

WORKDIR demo_web_server
RUN rebar3 as prod release

FROM alpine
RUN apk add --no-cache ncurses-libs

COPY --from=0 /buildroot/demo_web_server/_build/prod/rel/demo_web_server /demo_web_server

EXPOSE 8080

CMD ["/demo_web_server/bin/demo_web_server","foreground"]