FROM node:22

RUN npm install -g @github/copilot

WORKDIR /workspace

ENTRYPOINT ["copilot"]

# docker build -t copilot-cli -f docker/copilot_cli.Dockerfile .
# docker run -it --rm --user "$(id -u):$(id -g)" -v $(pwd):/workspace -v ~/.copilot:/home/node/.copilot copilot-cli --allow-all-tools
