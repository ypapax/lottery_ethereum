ARG GO_VERSION=1.12
FROM golang:${GO_VERSION}
RUN go get -u github.com/AtlantPlatform/ethereum-playbook
CMD ethereum-playbook "$@"