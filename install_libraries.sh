
# utils
apt update
apt install -y htop nvtop

# install python stuff
pip install uv
if [ ! -d .venv ]; then
	uv venv
fi
uv pip install vllm
uv pip install git+https://github.com/huggingface/transformers.git --upgrade


# install opencode
curl -fsSL https://opencode.ai/install | bash