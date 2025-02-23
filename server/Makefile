dev:
	export APP_ENV=dev && go run ./cmd/myapp/main.go

prod:
	export APP_ENV=prod && go run ./cmd/myapp/main.go

PROTOC=protoc
PROTOC_GEN_GO=$(GOBIN)/protoc-gen-go
PROTOC_GEN_GO_GRPC=$(GOBIN)/protoc-gen-go-grpc

PROTO_DIR=../proto
GEN_DIR=./gen
PROTO_FILES=$(wildcard $(PROTO_DIR)/*.proto)

proto: ../proto/*.proto
	$(PROTOC) -I $(PROTO_DIR) \
		--go_out=$(GEN_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_out=$(GEN_DIR) \
		--go-grpc_opt=paths=source_relative \
		$(PROTO_FILES)

proto_%: ../proto/%.proto
	$(PROTOC) -I $(PROTO_DIR) \
	--go_out=$(GEN_DIR) \
	--go_opt=paths=source_relative \
	--go-grpc_out=$(GEN_DIR) \
	--go-grpc_opt=paths=source_relative \
	$(PROTO_DIR)/$*.proto