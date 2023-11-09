TARGET=samplecrd-controller
EXEC_DIR=/Users/ming/go/src/k8s.io/code-generator/generate-groups.sh
PROJECT=/Users/ming/Documents/Code/k8s-controller-custom-resource
CUSTOM_RESOURCE=samplecrd:v1

.PHONY: tidy
tidy:
	go mod tidy

.PHONY: clear
clear:
	@go clean -i ./...
	@rm -f samplecrd-controller

.PHONY: build
build: clear
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${TARGET} .

.PHONY: regenerate
regenerate:
	"${EXEC_DIR}/generate-groups.sh" all "${PROJECT}/pkg/client" "${PROJECT}/pkg/apis" "${CUSTOM_RESOURCE}" --go-header-file "${EXEC_DIR}"/hack/boilerplate.go.txt -v 10