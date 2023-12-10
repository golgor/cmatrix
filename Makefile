.PHONY: 

all:
	@echo "make build"
	@echo "    Biuld the Docker image."
	@echo "make run"
	@echo "    Run the Docker image and remove container after exit."

build:
	docker build . -t golgor/cmatrix

run:
	docker run --rm -it golgor/cmatrix

