
# the IS_SANDBOX env var is needed to allow --dangerous-skip-permissions
ANTHROPIC_BASE_URL=http://localhost:8000 ANTHROPIC_API_KEY=dummy ANTHROPIC_AUTH_TOKEN=dummy ANTHROPIC_DEFAULT_OPUS_MODEL=my-model ANTHROPIC_DEFAULT_SONNET_MODEL=my-model ANTHROPIC_DEFAULT_HAIKU_MODEL=my-model IS_SANDBOX=1 claude --dangerously-skip-permissions