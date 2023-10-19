LOCAL_IP=$(shell ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')

all:
	@bash ./scripts/run.sh "run"

test:
	@bash ./scripts/test.sh $(LOCAL_IP)

clean:
	@bash ./scripts/run.sh "clean"

re: clean all

check:
	@docker -v
	@k3d --version
	@kubectl version 2>/dev/null || true
