# Mission Control Agents

Runtime environment for autonomous AI agents in the Isekai Crossover Legion.

## Structure

```
src/
├── core/           # Shared agent runtime logic
│   ├── heartbeat.js
│   ├── task-executor.js
│   └── llm-client.js
├── profiles/       # Individual agent configurations
│   ├── lelouch/
│   ├── cc/
│   ├── meliodas/
│   ├── shiroe/
│   ├── demiurge/
│   ├── rimuru/
│   └── senku/
└── index.js        # Main entry point
```

## Agents (7 Active)

| Agent | Layer | Role | Heartbeat |
|-------|-------|------|-----------|
| Lelouch | Strategic | Supreme Strategist | 5min |
| C.C. | Analyst | Silent Analyst | Silent |
| Meliodas | Lead | DevOps Lead | 10min |
| Shiroe | Lead | Trading Architect | 30min |
| Demiurge | Specialist | Security Auditor | 20min |
| Rimuru | Specialist | Data Engineer | 20min |
| Senku | Specialist | Research Specialist | On-demand |

## Development

```bash
# Run locally
npm run dev

# Deploy to VPS
npm run deploy:agents
```

## Deployment

Agents run on VPS `fight-uno` managed by PM2.

See [DEPLOYMENT.md](../../docs/DEPLOYMENT.md) for full deployment guide.
