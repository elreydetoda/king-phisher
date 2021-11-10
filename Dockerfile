FROM mikefarah/yq:latest as yq-bin

FROM ubuntu:20.04

COPY --from=yq-bin /usr/bin/yq /usr/local/bin/yq

WORKDIR /opt/king-phisher
RUN mkdir -p data/server/king_phisher/plugins
ENTRYPOINT [ "entrypoint.sh" ]

COPY . .

ENV DEBIAN_FRONTEND=noninteractive

RUN cp ./docker/entrypoint.sh /usr/local/bin/

RUN set -ex && ./tools/install.sh --skip-client --no \
        && rm -rf /var/lib/apt/lists/*
