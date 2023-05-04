IMAGE_NAME = emoji-captcha-api
IMAGE_TAG = latest
REGISTY = ghcr.io/xzeldon
IMAGE = $(IMAGE_NAME):$(IMAGE_TAG)
PORT = 8080

build:
	docker buildx build -t $(IMAGE) .

run:
	docker run --name $(IMAGE_NAME) --init --rm -it -p $(PORT):8080 $(IMAGE)

tag:
	docker tag $(IMAGE) $(REGISTY)/$(IMAGE_NAME)

push:
	docker push $(REGISTY)/$(IMAGE)