registry=jiwoodidy

all: go1.9.7 go1.10 python2.7 python3.4

go1.9.7: go_version = 1.9.7
go1.9.7:
	docker build -t $(registry)/go:$(go_version) --build-arg REGISTRY=$(registry) --build-arg GO_VERSION=$(go_version) ./go
	#docker build -t $(registry)/go:$(go_version) --build-arg HANDLER_NAME=main --build-arg REGISTRY=$(registry) --build-arg GO_VERSION=$(go_version) ./go
	docker push $(registry)/go:$(go_version)

go1.10: go_version = 1.10
go1.10:
	docker build -t $(registry)/go:$(go_version) --build-arg REGISTRY=$(registry) --build-arg GO_VERSION=$(go_version) ./go
	docker push $(registry)/go:$(go_version)


python2.7: python_version = 2.7
python2.7:
	docker build -t $(registry)/python:$(python_version) --build-arg REGISTRY=$(registry) --build-arg VERSION=$(python_version) ./python
	docker push $(registry)/python:$(python_version)

python3.4: python_version = 3.4
python3.4:
	docker build -t $(registry)/python:$(python_version) --build-arg REGISTRY=$(registry) --build-arg VERSION=$(python_version) ./python3
	docker push $(registry)/python:$(python_version)
