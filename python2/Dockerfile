# Argruments from FROM
ARG REGISTRY
ARG VERSION=2.7

# Get fxwatcher
FROM ${REGISTRY}/fxwatcher:latest as watcher

# Function Environment Prepare
FROM python:${VERSION}-alpine

ARG ADDITIONAL_PACKAGE
## Alternatively use ADD https:// (which will not be cached by Docker builder)
RUN apk --no-cache add curl ${ADDITIONAL_PACKAGE} \
    && apk del curl --no-cache

COPY --from=watcher /go/src/github.com/openfx/openfx/fxwatcher/fxwatcher .
RUN chmod +x ./fxwatcher

## Add non root user
RUN addgroup -S app && adduser -S -g app app
RUN chown app /home/app

USER app

ENV PATH=$PATH:/home/app/.local/bin

WORKDIR /home/app/

COPY index.py           .
COPY requirements.txt   .
RUN pip install -r requirements.txt

RUN mkdir -p function
RUN touch ./function/__init__.py
WORKDIR /home/app/function/
COPY function/requirements.txt	.
RUN pip install --user -r requirements.txt

WORKDIR /home/app/

USER root
COPY function           function
RUN chown -R app:app ./
USER app

ENV FXPROCESS="python index.py"

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fxwatcher"]
