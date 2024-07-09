FROM debian:12-slim

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y git curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" \
        --output /tmp/vscode-cli.tar.gz && \
    tar -xf /tmp/vscode-cli.tar.gz -C /usr/bin && \
    rm /tmp/vscode-cli.tar.gz

RUN apt-get update && apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

ENV HOME="/root"

WORKDIR $HOME

RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv

ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN pyenv install 3.11
RUN pyenv install 3.12
RUN pyenv global 3.12

RUN curl -sSL https://pdm-project.org/install-pdm.py | python3 -

ENV PATH=/root/.local/bin:$PATH

# RUN code --install-extension editorconfig.editorconfig && \
#     code --install-extension tamasfe.even-better-toml && \
#     code --install-extension vscodevim.vim && \
#     code --install-extension eamodio.gitlens && \
#     code --install-extension ms-python.python && \
#     code --install-extension ms-python.mypy-type-checker && \
#     code --install-extension ms-python.vscode-pylance && \
#     code --install-extension Cameron.vscode-pytest && \
#     code --install-extension charliermarsh.ruff

CMD [ "code", "tunnel", "--accept-server-license-terms" ]
