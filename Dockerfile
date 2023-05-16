FROM golang:1.20-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .

RUN go build -o /calculator

FROM gcr.io/distroless/base-debian10@sha256:0fb35c1344279738e46848363af7a9c6dc210c22f9dd308c5bf32830c0acd6c7

WORKDIR /

COPY --from=build /calculator /calculator

USER nonroot:nonroot

ENTRYPOINT ["/calculator"]
