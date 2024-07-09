.PHONY: build

NAME		:= ghcr.io/clayman083/vscode-tunnels
VERSION		?= latest

build:
	docker build -t ${NAME} .
	docker tag ${NAME} ${NAME}:$(VERSION)
