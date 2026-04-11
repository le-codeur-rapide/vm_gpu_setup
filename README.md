# vm_gpu_setup


- How to download models directly in RAM (so no need to buy disk in run pod)
mkdir -p /dev/shm/vllm-models
and add --download-dir /dev/shm/vllm-models to vllm serve
-> but then i have a oom oh H100, maybe it is better to just buy the disk ?

## Experiment on 3x RTX 5090 (282Gb RAM, 3x 32GB Vram)

VLLM setup:
```bash
uv run vllm serve Jackrong/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled  --tokenizer Qwen/Qwen3.5-27B       --quantization fp8       --dtype float16        --gpu-memory-utilization 0.90     --served-model-name my-model       --enable-auto-tool-choice       --tool-call-parser qwen3_coder       --download-dir /dev/shm/vllm-models --pipeline_parallel_size=3
```

Opencode setup
```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "myprovider": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Runpod vLLM",
      "options": {
        "baseURL": "https://localhost:8000/v1",
        "apiKey": "dummy"
      },
      "models": {
        "my-model": {
          "name": "my-model"
        }
      }
    }
  },
  "model": "myprovider/my-model",
  "small_model": "myprovider/my-model"
}
```

Result:
```
(APIServer pid=19123) INFO:     127.0.0.1:36764 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=19123) INFO 04-11 11:20:38 [loggers.py:259] Engine 000: Avg prompt throughput: 1069.9 tokens/s, Avg generation throughput: 5.1 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 3.1%, Prefix cache hit rate: 0.0%
(APIServer pid=19123) INFO 04-11 11:20:48 [loggers.py:259] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 5.3 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 0.0%
(APIServer pid=19123) INFO 04-11 11:20:58 [loggers.py:259] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 0.0 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 0.0%
(APIServer pid=19123) INFO:     127.0.0.1:41926 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=19123) INFO:     127.0.0.1:41926 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=19123) INFO 04-11 11:21:38 [loggers.py:259] Engine 000: Avg prompt throughput: 2173.6 tokens/s, Avg generation throughput: 11.3 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 0.0%
(APIServer pid=19123) INFO 04-11 11:21:48 [loggers.py:259] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 0.0 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 0.0%
```

-> No cache usage
-> ~5-10 tok / sec
