# DSL Reference

Agentform uses a declarative schema inspired by HCL (HashiCorp Configuration Language) to define agents, workflows, and policies.

## Blocks

### `agentform`

Defining project metadata.

```hcl
agentform {
  version = "0.1"
  project = "my-project"
}
```

### `variable`

Input variables for the configuration.

```hcl
variable "api_key" {
  type        = string
  description = "API key"
  sensitive   = true
}
```

### `provider`

Configure an LLM provider.

```hcl
provider "llm.openai" "default" {
  api_key = var.api_key
}
```

### `model`

Define a model instance.

```hcl
model "gpt4" {
  provider = provider.llm.openai.default
  id       = "gpt-4"
}
```

### `agent`

Define an AI agent.

```hcl
agent "helper" {
  model = model.gpt4
  instructions = "You are a helper."
}
```

### `workflow`

Define a workflow of steps.

```hcl
workflow "main" {
  entry = step.start
  step "start" {
    type = "llm"
    agent = agent.helper
    next = step.end
  }
}
```
