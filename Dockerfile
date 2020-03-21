FROM golang:latest


LABEL ios.k8s.display-name="klopaphere-demands" \
    maintainer="Keith Tenzer <ktenzer@redhat.com>"


RUN mkdir -p /go/src/github.com/klopaphere-demands
RUN mkdir -p /app

WORKDIR /go/src/github.com/klopaphere-demands

ENV GOPATH=/go
ENV GOBIN=/app

RUN curl https://raw.githubusercontent.com/golang/dep/v0.5.1/install.sh | sh

COPY . /go/src/github.com/klopaphere-demands

RUN $GOBIN/dep ensure

RUN go build github.com/klopaphere-demands/models
RUN go install github.com/klopaphere-demands/service

RUN chown -R 1001:0 /app && \
    chmod -R 775 /app

RUN chmod -R 777 /tmp

RUN echo "1.0" > /etc/imageversion

USER 1001

WORKDIR /app

CMD /app/service
