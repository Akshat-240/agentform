# Agentform Examples

The [`examples/`](https://github.com/agentform-team/agentform/tree/main/examples) directory contains ready-to-use configurations demonstrating various Agentform features.

## Examples Overview

| Example | Difficulty | Description |
|---------|------------|-------------|
| [Simple Agent](#simple-agent) | Beginner | Basic LLM agent answering questions |
| [Multi-Agent](#multi-agent) | Intermediate | Multiple agents with conditional routing |
| [Filesystem Agent](#filesystem-agent) | Intermediate | File operations via MCP server |
| [PR Reviewer](#pr-reviewer) | Advanced | GitHub PR reviews with human approval |

## Simple Agent

**Directory:** [`simple-agent/`](https://github.com/agentform-team/agentform/tree/main/examples/simple-agent)

The simplest possible Agentform configuration. A single agent that answers questions using OpenAI.

### Run It

```bash
cd examples/simple-agent
agentform run ask --var openai_api_key=$OPENAI_API_KEY
```
