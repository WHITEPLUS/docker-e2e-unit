NAME      := e2e-uat
REGISTRY  := whiteplus/$(NAME)
VERSION   := 20170612

.PHONY: build push example


build:
	cd $(VERSION); docker build -t $(NAME):$(VERSION) .


version:
	@docker run -it --entrypoint sh $(NAME):$(VERSION) -c "python --version"


example-start:
	docker run -itd --shm-size=1024m --cap-add=SYS_ADMIN --name e2e-uat-example $(NAME):$(VERSION)


example-stop:
	docker stop e2e-uat-example
	docker rm e2e-uat-example


example:
	@docker exec e2e-uat-example rm -rf /tmp/example
	@docker cp example e2e-uat-example:/tmp/example
	@docker exec e2e-uat-example discover-test /tmp/example


push: build
	docker tag $(NAME):$(VERSION) $(REGISTRY):$(VERSION)
	docker push $(REGISTRY):$(VERSION)


push-latest: build
	docker tag $(NAME):$(VERSION) $(REGISTRY):latest
	docker push $(REGISTRY):latest
