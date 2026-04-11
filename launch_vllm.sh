
# to download models in ram
mkdir -p /dev/shm/vllm-models

# uv run vllm serve openai/gpt-oss-20b --served-model-name my-model --enable-auto-tool-choice --tool-call-parser openai

uv run vllm serve --model Jackrong/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled --tokenizer Qwen/Qwen3.5-27B \
    --host 0.0.0.0 --port 8000 --dtype bfloat16 --enable-prefix-caching \
    --kv-cache-dtype fp8 --max-model-len 210000 --chat-template-content-format string \
    --enable-auto-tool-choice --tool-call-parser qwen3_coder --reasoning-parser qwen3 --download-dir /dev/shm/vllm-models --quantization fp8 

uv run vllm serve Jackrong/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled   \
    --tokenizer Qwen/Qwen3.5-27B   \
    --quantization fp8   \
    --dtype float16   \
    --max-model-len 8192   \
    --gpu-memory-utilization 0.90 \
    --served-model-name my-model   \
    --enable-auto-tool-choice   \
    --tool-call-parser openai   \
    --download-dir /dev/shm/vllm-models


# this one worked on 3 x RTX 5090
uv run vllm serve Jackrong/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled       --tokenizer Qwen/Qwen3.5-27B       --quantization fp8       --dtype float16       --max-model-len 8192       --gpu-memory-utilization 0.90     --served-model-name my-model       --enable-auto-tool-choice       --tool-call-parser openai       --download-dir /dev/shm/vllm-models --pipeline_parallel_size=3