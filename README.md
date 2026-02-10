# Mission Control Monorepo

Unified repository for the **Isekai Crossover Legion** multi-agent AI system.

## Quick Start

```bash
# Install dependencies
npm install

# Run dashboard locally
npm run dev:dashboard

# Deploy Convex schema
npm run convex:deploy

# Deploy agents to VPS
npm run deploy:agents
```

## Repository Structure

```
mission-control/
├── packages/
│   ├── dashboard/    # Next.js web dashboard
│   ├── convex/       # Shared Convex backend
│   ├── agents/       # Agent runtime system
│   └── shared/       # Shared utilities & types
├── docs/             # Comprehensive documentation
├── knowledge-base/   # Agent persistent memory
└── scripts/          # Deployment & utility scripts
```

## Documentation

- [Architecture Overview](docs/architecture.md)
- [Workspace Map](docs/workspace-map.md)
- [Deployment Guide](docs/deployment.md)
- [Agent Personas](docs/PERSONAS.md)

## Deployments

- **Dashboard**: https://mission-control-dashboard-amber.vercel.app
- **Convex**: https://dashboard.convex.dev/d/ceaseless-bullfrog-373
- **Agents**: VPS `fight-uno` (PM2-managed)

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.
