all:
	@bash ./scripts/run.sh "run"

clean:
	@bash ./scripts/run.sh "clean"

re: clean all

check:
	@docker -v
	@k3d --version
	@kubectl version 2>/dev/null || true
