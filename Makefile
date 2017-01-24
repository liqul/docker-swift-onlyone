SWIFT_USER_PASSWORD=testing
CNTR=onlyone
CNTR_IMAGE=swift-onlyone
DATA_CNTR=SWIFT_DATA
DATA_CNTR_IMAGE=busybox
LOCAL_PORT=12345
DOCKER_PORT=8080

all: build stop delete run_new ps

run:
	-docker run \
		-d \
		--name $(CNTR) \
  	-v /srv:/srv:rw \
  	-p $(LOCAL_PORT):$(DOCKER_PORT) \
  	-e DELETE=0 \
    $(CNTR_IMAGE)	

run_new:
	-docker run \
	  -d \
	  --name $(CNTR) \
  	-v /srv:/srv:rw \
  	-p $(LOCAL_PORT):$(DOCKER_PORT) \
  	-e DELETE=1 \
    $(CNTR_IMAGE)

delete:
	-docker rm -f $(CNTR) 

bash:
	docker exec -i -t $(CNTR) /bin/bash

build:
	docker build -t $(CNTR_IMAGE) .

logs:
	docker logs $(CNTR) 

stop:
	docker stop $(CNTR)

ps:
	docker ps
