# Argrumnets for FROM
ARG REGISTRY
ARG GO_VERSION=1.9.7
ARG WATCHER_VERSION=0.1.0

# Get fxwatcher - if fxwatcher is uploaded on github, remove this line.
FROM ${REGISTRY}/fxwatcher:${WATCHER_VERSION}-go${GO_VERSION} as watcher

# Function Build
FROM golang:${GO_VERSION} as builder
ARG HANDLER_DIR=${GOPATH}/src/openfx/handler
ARG HANDLER_FILE=${GOPATH}/src/openfx/handler/handler
ARG HANDLER_NAME=Handler

# Install dep
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh


RUN mkdir -p ${GOPATH}/src/github.com/openfx/openfx/fxwatcher/go
WORKDIR ${GOPATH}/src/github.com/openfx/openfx/fxwatcher/go
COPY --from=watcher ${GOPATH}/src/github.com/openfx/openfx/fxwatcher/go .
RUN go build -o fxwatcher .

RUN mkdir -p ${HANDLER_DIR}
WORKDIR ${HANDLER_DIR}
COPY . .
RUN dep ensure
RUN go build -o ${HANDLER_FILE} -buildmode=plugin .

# Run fxwatcher
FROM golang:${GO_VERSION}
ARG HANDLER_DIR=${GOPATH}/src/openfx/handler
ENV HANDLER_FILE=${GOPATH}/src/openfx/handler/handler
ENV HANDLER_NAME=Handler

COPY --from=builder /go/src/github.com/openfx/openfx/fxwatcher/go/fxwatcher /fxwatcher
RUN chmod +x /fxwatcher

COPY --from=builder ${HANDLER_DIR} ${HANDLER_DIR}

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["/fxwatcher"]
