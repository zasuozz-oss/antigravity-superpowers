---
name: mcp-builder
description: Use when building, designing, or implementing MCP (Model Context Protocol) servers. Use when the user wants to create tools that enable LLMs to interact with external services, APIs, or data sources via MCP.
---

# MCP Server Development Guide

Create MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools. The quality of an MCP server is measured by how well it enables LLMs to accomplish real-world tasks.

## High-Level Workflow

### Phase 1: Deep Research and Planning

1. **Understand the service** the MCP server will interact with
   - Read API documentation using `read_url_content`
   - Identify key operations users would want
   - Note authentication requirements

2. **Design the tool interface**
   - Each tool should map to a clear user intent
   - Use descriptive names: `search_issues`, `create_pr`, not `api_call`
   - Design input schemas that are LLM-friendly:
     - Use clear parameter names
     - Provide descriptions for each parameter
     - Set sensible defaults
     - Mark required vs optional clearly

3. **Plan error handling**
   - Map API errors to helpful messages
   - Include retry logic for transient failures
   - Validate inputs before making API calls

### Phase 2: Implementation

**Choose SDK:**
- **TypeScript**: `@modelcontextprotocol/sdk` — most mature, recommended
- **Python**: `mcp` package — good for Python-heavy workflows

**Project setup (TypeScript):**
```bash
npx -y create-mcp-server@latest ./my-mcp-server
```

**Project setup (Python):**
```bash
pip install mcp
```

**Core structure:**
```
my-mcp-server/
├── src/
│   ├── index.ts          # Entry point, server setup
│   ├── tools/            # Tool definitions
│   │   ├── search.ts
│   │   └── create.ts
│   └── lib/              # Shared utilities
│       ├── api-client.ts # API wrapper
│       └── types.ts      # Type definitions
├── package.json
└── tsconfig.json
```

**Key implementation principles:**
- Return structured data (JSON), not raw API responses
- Filter and summarize large responses — LLMs have context limits
- Include relevant metadata (IDs, URLs) so LLMs can chain operations
- Handle pagination automatically where possible
- Log errors with enough context to debug

### Phase 3: Testing

1. **Unit test each tool** with mocked API responses
2. **Integration test** with real API (if safe)
3. **LLM test**: Actually use the MCP server with an LLM client
   - Does the tool description make it clear when to use it?
   - Are the results useful for the LLM to reason about?
   - Can the LLM chain multiple tools effectively?

Use `run_command` to execute tests:
```bash
npm test
```

### Phase 4: Configuration & Deployment

**Register in MCP config** (example for Claude Desktop / compatible clients):
```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["path/to/my-mcp-server/dist/index.js"],
      "env": {
        "API_KEY": "your-api-key"
      }
    }
  }
}
```

## Quick Reference: Tool Design

| Principle | Good Example | Bad Example |
|-----------|-------------|-------------|
| Clear names | `search_repositories` | `api_repos` |
| Focused scope | One action per tool | Multi-purpose tool |
| LLM-friendly output | Summarized, structured JSON | Raw API dump |
| Error messages | "Repository 'foo' not found" | "404 error" |
| Descriptions | "Search GitHub repos by name, language, or topic" | "Search repos" |

## Common Pitfalls

- **Too many tools**: Start with 3-5 core operations, expand later
- **Raw API passthrough**: Always transform/filter API responses for LLM consumption
- **Missing context**: Include URLs and IDs in responses so LLMs can reference them
- **No input validation**: Validate before calling the API — better error messages
- **Ignoring pagination**: Auto-paginate or clearly indicate more results exist

## MCP Specification Reference

For the full MCP specification, fetch the latest docs:
```
read_url_content("https://spec.modelcontextprotocol.io/specification/")
```

For SDK documentation:
- TypeScript: `read_url_content("https://github.com/modelcontextprotocol/typescript-sdk")`
- Python: `read_url_content("https://github.com/modelcontextprotocol/python-sdk")`
