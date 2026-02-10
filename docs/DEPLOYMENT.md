# Deployment Guide

> **Audience**: Developers & DevOps  
> **Last Updated**: 2026-02-11

---

## Prerequisites

- **Node.js**: v20.0.0+
- **npm**: v10.0.0+
- **Git**: Latest
- **SSH Access**: To VPS `fight-uno`
- **Convex Account**: Access to `ceaseless-bullfrog-373`
- **Vercel Account**: (Optional, auto-deploys from GitHub)

---

## Local Development Setup

### 1. Clone the Monorepo

```bash
cd /Users/faiqnau/fight
git clone https://github.com/vforvaick/mission-control.git
cd mission-control
```

### 2. Install Dependencies

```bash
npm install
```

This installs dependencies for all workspace packages.

### 3. Set Up Convex

```bash
# Login to Convex (one-time)
npx convex login

# Start Convex dev server
npm run convex:dev
```

### 4. Run Dashboard Locally

```bash
# In a new terminal
npm run dev:dashboard
```

Visit: http://localhost:3000

---

## Dashboard Deployment (Vercel)

### Automatic Deployment

**Trigger**: Push to `main` branch on GitHub  
**Platform**: Vercel  
**URL**: https://mission-control-dashboard-amber.vercel.app

```bash
git add .
git commit -m "feat: xyz"
git push origin main
```

Vercel detects the push and auto-deploys.

### Manual Deployment (if needed)

```bash
cd packages/dashboard
vercel --prod
```

### Environment Variables

Set in Vercel dashboard:
- `NEXT_PUBLIC_CONVEX_URL`: `https://ceaseless-bullfrog-373.convex.cloud`
- `CONVEX_DEPLOYMENT`: `prod:ceaseless-bullfrog-373`

---

## Convex Backend Deployment

### Deploy Schema & Functions

```bash
npm run convex:deploy
```

This pushes:
- Schema changes (`schema.ts`)
- Mutations/queries (`agents.ts`, `tasks.ts`, etc.)
- Migrations

### Run a Migration

```bash
# From Convex dashboard → Functions tab
# Run: migrations/{migrationName}
```

Or via CLI:
```bash
npx convex run migrations:{functionName}
```

---

## Agent Deployment (VPS)

### Initial Setup (One-Time)

#### 1. SSH into VPS

```bash
ssh fight-uno
```

#### 2. Clone Repo to VPS

```bash
cd /home/vforvaick/.openclaw
git clone https://github.com/vforvaick/mission-control.git
cd mission-control
```

#### 3. Install Dependencies

```bash
npm install
```

#### 4. Set Up PM2 Ecosystem

(Placeholder — agent package structure pending)

```bash
# Install PM2 globally
npm install -g pm2

# Start agents
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

### Ongoing Deployment

Use the deployment script:

```bash
# From local machine
npm run deploy:agents
```

This script (`scripts/deploy-agents.sh`) does:
1. `rsync` agent package to VPS
2. SSH into VPS
3. `npm install` (if package.json changed)
4. `pm2 restart all`

---

## Full Deployment Checklist

When deploying changes that touch multiple components:

- [ ] 1. **Test Locally**
  ```bash
  npm run dev:dashboard
  npm run convex:dev
  ```

-  [ ] 2. **Commit & Push**
  ```bash
  git add .
  git commit -m "feat: description"
  git push origin main
  ```

- [ ] 3. **Deploy Convex**
  ```bash
  npm run convex:deploy
  ```

- [ ] 4. **Verify Dashboard** (auto-deploys from GitHub)
  - Check: https://mission-control-dashboard-amber.vercel.app

- [ ] 5. **Deploy Agents**
  ```bash
  npm run deploy:agents
  ```

- [ ] 6. **Verify Agents**
  ```bash
  ssh fight-uno "pm2 list"
  ssh fight-uno "pm2 logs --lines 50"
  ```

- [ ] 7. **Check Convex Activity**
  - Open Convex dashboard
  - Verify agent heartbeats in `activity` table

---

## Rollback Procedures

### Dashboard Rollback

Vercel keeps deployment history:
1. Go to Vercel dashboard → Deployments
2. Find previous deployment
3. Click "Promote to Production"

### Convex Rollback

Convex doesn't support schema rollbacks. To revert:
1. Create a new migration that undoes changes
2. Deploy: `npm run convex:deploy`

### Agent Rollback

```bash
ssh fight-uno
cd /home/vforvaick/.openclaw/mission-control
git log --oneline  # Find commit hash
git checkout {previous-commit}
pm2 restart all
```

---

## Troubleshooting

### Dashboard Build Fails

```bash
# Check build locally
cd packages/dashboard
npm run build
```

Common issues:
- Missing environment variables
- TypeScript errors
- Invalid Convex imports

### Agents Not Heartbeating

```bash
ssh fight-uno
PM2 logs {agent-name}
```

Common issues:
- Convex connection failed (check `.env`)
- PM2 process crashed
- Node.js version mismatch

### Convex Schema Conflicts

- Ensure all `v.optional()` for new fields
- Run migrations in order
- Check Convex dashboard → Logs

---

## Monitoring

### Dashboard
- **URL**: https://mission-control-dashboard-amber.vercel.app
- **Logs**: Vercel dashboard → Functions → Logs

### Convex
- **URL**: https://dashboard.convex.dev/d/ceaseless-bullfrog-373
- **Metrics**: Requests, storage, function executions

### Agents (VPS)
```bash
ssh fight-uno "pm2 monit"
```

---

## Emergency Contacts

- **VPS**: `fight-uno` (IP in .ssh/config)
- **Convex Project**: `ceaseless-bullfrog-373`
- **GitHub Repo**: https://github.com/vforvaick/mission-control
