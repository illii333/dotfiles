$env.config.buffer_editor = "hx"
$env.config.show_banner = false
$env.PROMPT_COMMAND = { || $"\e[33m\e[0m \e[94m($env.PWD)\e[0m \e[92m(/mnt/Study/helix/sh/2026_calendar.sh)\e[0m\n\e[33m󰎟\e[0m " }
alias al = scope aliases
alias blender = /mnt/Study/blender/blender
alias logseq = /mnt/Study/data/software/Logseq.AppImage
alias krita = /mnt/Study/data/software/krita.AppImage
alias vpn = /mnt/Study/data/software/v2rayN/v2rayN
alias zed = /mnt/Study/data/software/zed/bin/zed
alias godot = /mnt/Study/data/software/godot/Godot_v4.4.1-stable_linux.x86_64
# run-external "/mnt/Study/helix/sh/get_chinese_hour.sh"
# $env.PROMPT_COMMAND = { || $"\e[33m\e[0m \e[94m($env.PWD)\e[0m \e[92m(date now | format date '%H:%M:%S')\e[0m\n\e[33m󰎟\e[0m " }
alias mx = /mnt/Study/data/software/Motrix.AppImage
alias qwen3.5 = llama-cli -m /mnt/Study/data/software/AI/Qwen3.5-9B-Q4_K_M.gguf -c 8192
alias qwen3.6 = llama-cli -m /mnt/Study/data/software/AI/Qwen3.6-27B-Q4_K_M.gguf -c 262144 -b 65536 -n 2048 -t -1 --n-gpu-layers 99 -fa on -fit on --spec-type ngram-mod --spec-ngram-size-n 24 --draft-min 48 --draft-max 64 --ctx-checkpoints 4 --checkpoint-every-n-tokens 256
alias qwen3.5-web = llama-server -m /mnt/Study/data/software/AI/Qwen3.5-9B-Q4_K_M.gguf -c 8192 --port 8080
alias qwen3.6-web = llama-server -m /mnt/Study/data/software/AI/Qwen3.6-27B-Q4_K_M.gguf -c 16384 -b 512 -n 2048 -t -1 --n-gpu-layers 15 -fa on -fit off --spec-type none --host 0.0.0.0 --port 8080

