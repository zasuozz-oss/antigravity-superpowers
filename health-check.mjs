#!/usr/bin/env node

import Anthropic from "@anthropic-ai/sdk";

const start = Date.now();
const timestamp = new Date().toISOString();

try {
  const client = new Anthropic({
    apiKey: process.env.ANTHROPIC_API_KEY,
  });

  const response = await client.messages.create({
    model: "claude-opus-4-8",
    max_tokens: 10,
    messages: [{ role: "user", content: "ping" }],
  });

  const responseTime = Date.now() - start;
  const status = response.stop_reason === "end_turn" ? "OK" : "FAILED";

  console.log(`[${timestamp}] Health check: ${status} (${responseTime}ms)`);
  process.exit(status === "OK" ? 0 : 1);
} catch (error) {
  const responseTime = Date.now() - start;
  const errorMsg = error.message.includes("authentication")
    ? "FAILED - Auth error"
    : `FAILED - ${error.message.split("\n")[0]}`;
  console.log(`[${timestamp}] Health check: ${errorMsg} (${responseTime}ms)`);
  process.exit(1);
}
