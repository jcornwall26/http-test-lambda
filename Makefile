
TEST_PAYLOAD = \
'{ \
	"test_url": "https://httpbin.org/get" \
}'

get-ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 441128520970.dkr.ecr.us-east-1.amazonaws.com

create-ecr-repo:
	aws ecr create-repository --repository-name http-test-lambda --region us-east-1 --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE

build-image:
	docker build --platform linux/amd64 --provenance=false -t http-test-lambda:1.0 .

run-container:
	docker run --platform linux/amd64 -p 9000:8080 http-test-lambda:1.0

test-locally:
	curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d $(TEST_PAYLOAD)

tag-image:
	docker tag http-test-lambda:1.0 441128520970.dkr.ecr.us-east-1.amazonaws.com/http-test-lambda:1.0

push-image:
	docker push 441128520970.dkr.ecr.us-east-1.amazonaws.com/http-test-lambda:1.0
