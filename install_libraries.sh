
# utils
apt update
apt install -y htop nvtop

# install python stuff
pip install uv
if [ ! -d .venv ]; then
	uv venv
fi
uv pip install vllm


# claude code one liner
curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc

# setup env for claude code
export ANTHROPIC_BASE_URL="http://localhost:8000"
export ANTHROPIC_API_KEY="dummy"
export ANTHROPIC_DEFAULT_OPUS_MODEL="my-model"
export ANTHROPIC_DEFAULT_SONNET_MODEL="my-model"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="my-model"