dev:
	export APP_ENV=dev && go run ./cmd/myapp/main.go

prod:
	export APP_ENV=prod && go run ./cmd/myapp/main.go

docker_dev:
	docker build -t capstone-server:locall .
	docker run -d \
      --name capstone-server \
      -p 8080:8080 \
      -p 50051:50051 \
      -p 8000:8000 \
      -p 8001:8001 \
      --env-file .dev.env \
      capstone-server:locall

PROTOC=protoc
PROTOC_GEN_GO=$(GOBIN)/protoc-gen-go
PROTOC_GEN_GO_GRPC=$(GOBIN)/protoc-gen-go-grpc

PROTO_DIR=./proto
GEN_DIR=./gen
PROTO_FILES=$(wildcard $(PROTO_DIR)/*.proto)

.PHONY: proto
proto: ./proto/*.proto
	$(PROTOC) -I $(PROTO_DIR) \
		--go_out=$(GEN_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_out=$(GEN_DIR) \
		--go-grpc_opt=paths=source_relative \
		$(PROTO_FILES)

proto_%: ./proto/%.proto
	$(PROTOC) -I $(PROTO_DIR) \
	--go_out=$(GEN_DIR) \
	--go_opt=paths=source_relative \
	--go-grpc_out=$(GEN_DIR) \
	--go-grpc_opt=paths=source_relative \
	$(PROTO_DIR)/$*.proto