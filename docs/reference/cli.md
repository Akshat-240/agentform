# CLI Reference

Complete reference for the `agentform` command-line interface.

## Commands

### `agentform init`

Initialize a project and download external modules.

```bash
agentform init [directory]
```

**Description:** Downloads all external modules referenced in your `.af` files to the local `.af/modules/` directory. You must run this before compiling or running workflows that use external modules.

**Arguments:**
- `directory` (optional): Project directory. Defaults to current directory.

### `agentform validate`

Validate a specification file.

```bash
agentform validate <spec-file> [options]
```

### `agentform run`

Run a workflow.

```bash
agentform run <workflow-name> [options]
```
