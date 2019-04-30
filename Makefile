.PHONY: deps clean build

deploy: build
	export AWS_PROFILE=uneet-dev; sam package --output-template-file packaged.yaml --s3-bucket dev-media-unee-t
	export AWS_PROFILE=uneet-dev; sam deploy --template-file packaged.yaml --stack-name sam-test-app --capabilities CAPABILITY_IAM --region ap-southeast-1

deps:
	go get -u ./...

clean: 
	rm -rf ./hello-world/hello-world
	
build:
	GOOS=linux GOARCH=amd64 go build -o hello-world/hello-world ./hello-world

local:
	export AWS_PROFILE=uneet-dev; sam local start-api

logs:
	export AWS_PROFILE=uneet-dev; sam logs --name sam-test-app-HelloWorldFunction-UU3EOWUHDFWW --tail

test:
	curl http://127.0.0.1:3000/hello
