# Getting Started

This guide will help you get up and running with Agentform in minutes.

## Installation

### Quick Install

```bash
pip install agentform-cli
```

### Verify Installation

```bash
agentform --help
```

## Prerequisites

- Python 3.12 or higher
- An API key for at least one LLM provider (OpenAI, Anthropic, etc.)

## Your First Agent

Let's create a simple agent that can answer questions.

### 1. Set up your API key

```bash
export OPENAI_API_KEY="your-openai-key"
```

### 2. Create an agent spec

Create a file called `my-agent.af`:

```hcl
agentform {
  version = "0.1"
  project = "my-first-agent"
}

variable "openai_api_key" {
  type        = string
  description = "OpenAI API key"
  sensitive   = true
}

provider "llm.openai" "default" {
  api_key = var.openai_api_key
  default_params {
    temperature = 0.7
    max_tokens  = 2000
  }
}

policy "default" {
  budgets { max_cost_usd_per_run = 0.50 }
  budgets { timeout_seconds = 60 }
}

model "gpt4o_mini" {
  provider = provider.llm.openai.default
  id       = "gpt-4o-mini"
}

agent "assistant" {
  model = model.gpt4o_mini
  instructions = "You are a helpful assistant. Answer questions clearly and concisely."
  policy = policy.default
}

workflow "ask" {
  entry = step.process

  step "process" {
    type  = "llm"
    agent = agent.assistant
    input { question = input.question }
    output "answer" { from = result.text }
    next = step.end
  }

  step "end" { type = "end" }
}
```

### 3. Run it

Validate your spec:
```bash
agentform validate my-agent.af --var openai_api_key=$OPENAI_API_KEY
```

Run the workflow:
```bash
agentform run ask \
  --spec my-agent.af \
  --var openai_api_key=$OPENAI_API_KEY \
  --input '{"question": "What is the capital of France?"}'
```

You should see the agent's response!
