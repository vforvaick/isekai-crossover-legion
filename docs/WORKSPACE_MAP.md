# Workspace Map

> **Purpose**: Quick reference guide for navigating the Mission Control monorepo  
> **Last Updated**: 2026-02-11

---

## Directory Structure

```
mission-control/
├── packages/                    → All deployable code
│   ├── dashboard/              → Next.js web dashboard
│   ├── convex/                 → Shared backend (DB schema + functions)
│   ├── agents/                 → Agent runtime system (from VPS)
│   └── shared/                 → Common TypeScript types
├── docs/                       → All documentation (single source of truth)
├── knowledge-base/             → Agent persistent memory
├── scripts/                    → Deployment & utility scripts
└── .github/workflows/          → CI/CD pipelines
```

---

## Package Responsibilities

### `packages/dashboard`
**What it does**: Web UI for monitoring agents and managingasks
**Runs on**: Vercel (production), localhost:3000 (dev)
**Key files**:
- `app/`: Next.js pages (home, kanban, agents, activity)
- `components/`: Reusable UI components
- `lib/`: Utilities, Convex client setup

**How to run**:
```bash
npm run dev:dashboard
```

---

### `packages/convex`
**What it does**: Central data layer, real-time sync, serverless mutations
**Runs on**: Convex Cloud (`ceaseless-bullfrog-373`)
**Key files**:
- `schema.ts`: Database table definitions
- `agents.ts`, `tasks.ts`, etc.: Query/mutation functions
- `migrations/`: One-time schema updates

**How to deploy**:
```bash
npm run convex:deploy
```

---

### `packages/agents`
**What it does**: Autonomous AI agents that execute tasks
**Runs on**: VPS `fight-uno` (PM2-managed processes)
**Key files** (planned):
- `src/core/`: Shared agent logic (heartbeat, task executor)
- `src/profiles/`: Agent personas (lelouch, cc, meliodas, etc.)
- `src/skills/`: Reusable agent skills

**How to deploy**:
```bash
npm run deploy:agents
```

---

### `packages/shared`
**What it does**: Common TypeScript types used by dashboard and agents
**Key files**:
- `src/types.ts`: Type definitions for Agent, Task, etc.

---

## Documentation (`docs/`)

| File | Purpose |
|------|---------|
| `architecture.md` | High-level system overview, component diagram |
| `workspace-map.md` | This file — "what lives where" guide |
| `deployment.md` | Step-by-step deployment instructions |
| `PERSONAS.md` | Agent character profiles and roles |
| `PROTOCOL.md` | Inter-agent communication rules |
| `database.md` | Convex schema reference |
| `CHANGELOG.md` | Version history |
| `ROADMAP.md` | Planned features |
| `HANDOVER_PLAN.md` | Technical handover for new devs |

---

## Knowledge Base (`knowledge-base/`)

**Purpose**: Persistent agent memory across sessions

```
knowledge-base/
├── trading/              → Market research, backtest results
├── devops/               → Infrastructure notes, deployment logs
└── research/             → Scientific findings, patterns
```

**Access**: Agents read/write directly via filesystem

---

## Scripts (`scripts/`)

| Script | Purpose |
|--------|---------|
| `deploy-agents.sh` | Sync agent package to VPS + restart PM2 |
| `deploy-dashboard.sh` | (Optional) Manual Vercel deploy |
| `sync-vps.sh` | Pull latest code to VPS |

---

## How to Find Things

### "I need to modify the agent roster"
→ `packages/convex/schema.ts` (table structure)  
→ `packages/convex/seed.ts` (initial data)  
→ `docs/PERSONAS.md` (persona specs)

### "I need to add a new Kanban feature"
→ `packages/dashboard/components/kanban/`  
→ `packages/convex/tasks.ts` (backend logic)

### "I need to change how agents execute tasks"
→ `packages/agents/src/core/task-executor.ts` (when implemented)

### "I need to update deployment process"
→ `docs/deployment.md`  
→ `scripts/deploy-*.sh`

### "I need to understand the overall system"
→ `docs/architecture.md`  
→ `docs/database.md`

---

## Common Workflows

### Adding a New Agent
1. Add to `packages/convex/schema.ts` (already has `agents` table)
2. Add to `packages/convex/seed.ts`
3. Document in `docs/PERSONAS.md`
4. Create profile in `packages/agents/src/profiles/{agent-name}/`
5. Deploy: `npm run convex:deploy && npm run deploy:agents`

### Updating Convex Schema
1. Edit `packages/convex/schema.ts`
2. Create migration in `packages/convex/migrations/`
3. Test locally: `npm run convex:dev`
4. Deploy: `npm run convex:deploy`
5. Restart agents: `ssh fight-uno "pm2 restart all"`

### Deploying Everything
```bash
# 1. Commit and push to GitHub
git add . && git commit -m "feat: xyz" && git push

# 2. Deploy Convex schema
npm run convex:deploy

# 3. Deploy agents to VPS
npm run deploy:agents

# 4. Vercel auto-deploys dashboard from GitHub push
```
