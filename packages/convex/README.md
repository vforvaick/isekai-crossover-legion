# Convex Backend Package

Shared Convex backend for Mission Control system.

## Schema

- **agents**: Agent profiles, status, health metrics
- **tasks**: Kanban tasks with decomposition support
- **boards**: Organizational domains (Office, Trading, Personal, Deployment)
- **activity**: System-wide activity feed
- **comments**: Threaded task comments
- **agentMessages**: Inter-agent communication
- **subscriptions**: @mention tracking
- **notificationQueue**: Notification system
- **telegramInbox**: Telegram integration

## Development

```bash
# Watch mode with live reload
npm run dev

# Deploy to production
npm run deploy

# Generate types only
npm run codegen
```

## Usage in Other Packages

```typescript
import { api } from "@mission-control/convex/_generated/api";
import { useQuery, useMutation } from "convex/react";

// In dashboard or agents
const agents = useQuery(api.agents.list);
const createTask = useMutation(api.tasks.create);
```
