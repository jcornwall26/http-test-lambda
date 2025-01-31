
TEST_PAYLOAD = \
'{ \
	"test_url": "https://httpbin.org/get" \
}'

get-ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 734506455110.dkr.ecr.us-east-1.amazonaws.com

create-ecr-repo:
	aws ecr create-repository --repository-name http-test-lambda --region us-east-1 --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE

build-image:
	docker build --platform linux/amd64 -t http-test-lambda:latest .

run-container:
	docker run --platform linux/amd64 -p 9000:8080 http-test-lambda:latest

test-locally:

	curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d $(TEST_PAYLOAD)

tag-image:
	docker tag http-test-lambda:latest 734506455110.dkr.ecr.us-east-1.amazonaws.com/http-test-lambda:latest

push-image:
	docker push 734506455110.dkr.ecr.us-east-1.amazonaws.com/http-test-lambda:latest

create-lambda-role:
	aws iam create-role --role-name http-test-lambda-role --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

create-lambda:
	aws lambda create-function \
  --function-name http-test-lambda \
  --package-type Image \
  --code ImageUri=734506455110.dkr.ecr.us-east-1.amazonaws.com/http-test-lambda:latest \
  --role arn:aws:iam::734506455110:role/http-test-lambda-role \
  --region us-east-1

