#!/bin/bash
set -e

echo "🚀 Setting up your dev container..."

# Install global npm packages
npm install -g npm@latest
npm install -g yarn pnpm typescript ts-node nodemon eslint prettier
npm install -g @angular/cli @vue/cli create-react-app
npm install -g express-generator @nestjs/cli
npm install -g aws-cdk serverless vercel netlify-cli
npm install -g prisma @prisma/client
npm install -g http-server

# Install Python packages
pip3 install --upgrade pip
pip3 install --user virtualenv poetry pipenv
pip3 install --user jupyter notebook jupyterlab
pip3 install --user numpy pandas matplotlib scikit-learn
pip3 install --user flask django fastapi uvicorn
pip3 install --user requests beautifulsoup4 selenium
pip3 install --user pytest pytest-cov black mypy pylint
pip3 install --user boto3 awscli-local

# Install Go tools
go install github.com/cosmtrek/air@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/gopls@latest
go install github.com/ramya-rao-a/go-outline@latest
go install github.com/rogpeppe/godef@latest

# Install Rust tools
rustup component add rustfmt clippy rust-analyzer
cargo install cargo-edit cargo-watch cargo-audit cargo-tree

# Setup Fish shell config
mkdir -p ~/.config/fish

cat > ~/.config/fish/config.fish << 'FISH'
# Welcome message
set fish_greeting "🐟 Welcome to your Dev Container!"

# Aliases
alias ll='ls -la'
alias la='ls -a'
alias l='ls -l'
alias g='git'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias ga='git add'
alias gd='git diff'
alias dc='docker-compose'
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kga='kubectl get all'
alias kgs='kubectl get services'
alias kc='kubectl config'
alias kcx='kubectx'
alias kns='kubens'
alias tf='terraform'
alias tg='terragrunt'
alias h='history'
alias c='clear'
alias :q='exit'

# Add local bin to path
fish_add_path ~/.local/bin

# Starship prompt
if command -q starship
    starship init fish | source
end

# Set editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Set up environment variables for languages
set -gx GOPATH $HOME/go
set -gx GOBIN $GOPATH/bin
set -gx PATH $GOBIN $PATH

# Welcome message with system info
echo "   Container: Dev Environment v1.0"
echo "   OS: (uname -srm)"
echo "   Languages: Node $(node -v), Python $(python3 -V | cut -d' ' -f2), Go $(go version | cut -d' ' -f3), Rust $(rustc -V | cut -d' ' -f2)"
echo "   Tools: Git $(git --version | cut -d' ' -f3), Docker $(docker -v | cut -d' ' -f3 | tr -d ',')"
FISH

# Install Fisher and plugins
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish
fisher install edc/bass
fisher install patrickf1/fzf.fish
fisher install IlanCosman/tide@v5

# Configure tide prompt
echo 'y\ny\n1\n2\n3\n1\n4\n2\n' | tide configure

# Set up git aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global core.editor "nvim"

# Create sample project structure
mkdir -p /workspaces/projects/{node,python,go,rust,web,data}

# Create a test file for each language
echo 'console.log("Hello from Node.js!");' > /workspaces/projects/node/test.js
echo 'print("Hello from Python!")' > /workspaces/projects/python/test.py
echo 'package main\n\nimport "fmt"\n\nfunc main() {\n    fmt.Println("Hello from Go!")\n}' > /workspaces/projects/go/main.go
echo 'fn main() {\n    println!("Hello from Rust!");\n}' > /workspaces/projects/rust/main.rs
echo '<!DOCTYPE html>\n<html>\n<body>\n    <h1>Hello from Web!</h1>\n</body>\n</html>' > /workspaces/projects/web/index.html

# Print completion message
echo ""
echo "✅ Dev container setup complete!"
echo "📁 Your projects are in /workspaces/projects/"
echo "🚀 Start coding!"