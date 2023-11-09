TARGET=samplecrd-controller

.PHONY: tidy
tidy:
	go mod init
	go mod tidy

.PHONY: clear
clear:
	@go clean -i ./...
	@rm -f samplecrd-controller

.PHONY: build
build: clear
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${TARGET} .