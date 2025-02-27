#!/bin/bash

ARCHTYPE=$(uname -m)  #get the arch type
if tmux has-session -t ollama 2>/dev/null; then
  tmux attach-session -t ollama
else
  tmux new-session -d -s ollama
  if [ "$ARCHTYPE" = "x86_64" ]; then
    if [ ! -f ollama-linux-amd64.tgz ]; then
      tmux send-keys -t ollama "curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz" C-m
    fi
  elif [ "$ARCHTYPE" = "arm64" ]; then
    if [ ! -f ollama-linux-arm64.tgz ]; then
      tmux send-keys -t ollama "curl -L https://ollama.com/download/ollama-linux-arm64.tgz -o ollama-linux-arm64.tgz" C-m
    fi
  else
    if [ ! -f ollama-linux-amd64.tgz ]; then
      tmux send-keys -t ollama "curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz" C-m
    fi
  fi
  tmux send-keys -t ollama "mkdir -p ollama" C-m
  if [ "$ARCHTYPE" = "arm64" ]; then
      tmux send-keys -t ollama "tar -C ollama -xzvf ollama-linux-arm64.tgz" C-m
      tmux send-keys -t ollama "./ollama/bin/ollama serve" C-m
  else
      tmux send-keys -t ollama "tar -C ollama -xzvf ollama-linux-amd64.tgz" C-m
      tmux send-keys -t ollama "./ollama/bin/ollama serve" C-m
  fi
  tmux attach-session -t ollama
fi