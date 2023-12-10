# Build container image
FROM alpine as cmatrix-builder

WORKDIR /cmatrix
RUN apk update --no-cache && apk add git autoconf automake alpine-sdk ncurses-dev ncurses-static && \
    git clone https://github.com/spurin/cmatrix.git . && \
    autoreconf -i  && \
    mkdir -p /usr/lib/kbd/consolefonts /usr/share/consolefonts && \
    ./configure LDFLAGS="-static" && \
    make

# Cmatrix container image
FROM alpine

LABEL org.opencontainers.image.authors="Robert Nyström" \
    org.opencontainers.image.description="A test image to learn more about Docker"

RUN apk update --no-cache && \
    apk add ncurses-terminfo-base && \
    adduser -g "Robert Matrix" -s /usr/sbin/nologin -D -H golgor
COPY --from=cmatrix-builder /cmatrix/cmatrix /cmatrix

USER golgor
ENTRYPOINT ["./cmatrix"]
CMD ["-b"]