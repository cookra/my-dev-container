FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install additional system packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        build-essential \
        cmake \
        pkg-config \
        libssl-dev \
        curl \
        wget \
        unzip \
        zip \
        tree \
        jq \
        htop \
        tmux \
        neovim \
        ripgrep \
        fd-find \
        fzf \
        bat \
        httpie \
        sqlite3 \
        postgresql-client \
        mysql-client \
        redis-tools \
        telnet \
        netcat \
        dnsutils \
        iputils-ping \
        traceroute \
        mtr \
        tcpdump \
        nmap \
        net-tools \
        strace \
        ltrace \
        gdb \
        valgrind \
        lsof \
        vim \
        nano \
        less \
        man-db \
        && apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*

# Install starship prompt
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# Install bottom (better htop)
RUN curl -LO https://github.com/ClementTsang/bottom/releases/download/0.9.6/bottom_0.9.6_amd64.deb \
    && dpkg -i bottom_0.9.6_amd64.deb \
    && rm bottom_0.9.6_amd64.deb

# Set up fish as default shell
SHELL ["/usr/bin/fish", "--command"]
RUN chsh -s /usr/bin/fish vscode

# Create projects directory
RUN mkdir -p /workspaces/projects && chown -R vscode:vscode /workspaces

WORKDIR /workspaces/dev-env-container
