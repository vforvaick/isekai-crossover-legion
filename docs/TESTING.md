# Post-Migration Test Plan

> After the monorepo architectural migration (`isekai-crossover-legion`).  
> **Target URL**: https://isekai-crossover-legion-dashboard.vercel.app/  
> **Date**: 2026-02-11

---

## Phase 1: Smoke Test 🔥

Verify all core features still function on the new deployment. Open the Vercel URL and go through each item.

### 1.1 Page Loads
- [ ] **Dashboard home** (`/`) — renders without blank screen or errors
- [ ] **Kanban board** — columns visible (Backlog, Todo, In Progress, Review, Done)
- [ ] **Agents page** (`/agents`) — agent grid renders
- [ ] **Activity page** (`/activity`) — activity feed renders
- [ ] **Messages page** (`/messages`) — page loads

### 1.2 Authentication
- [ ] **Login** — GitHub OAuth redirects correctly
- [ ] **Session persists** — refresh page, still logged in
- [ ] **Auth guard** — unauthenticated user cannot access dashboard

### 1.3 Kanban Board
- [ ] **Tasks visible** — tasks appear in correct columns
- [ ] **Domain filtering** — switch between Office / Trading / Personal / Deployment tabs
- [ ] **Create task** — click "+" → fill form → submit → task appears
- [ ] **Edit task** — click task → edit title/description → save → changes persist
- [ ] **Delete task** — remove a task → confirm → task disappears
- [ ] **Drag & drop** — move task to different column → refresh → new position persists

### 1.4 Agent Grid
- [ ] **Agents render** — all 13 agents visible with avatars
- [ ] **Layer grouping** — Strategic / Analyst / Lead / Specialist sections
- [ ] **Status indicators** — active (green), idle (yellow), dormant (gray)
- [ ] **Agent detail page** — click any agent → `/agents/[handle]` loads with profile

### 1.5 Activity Feed
- [ ] **Events list** — recent activity entries with timestamps
- [ ] **Icons/colors** — correct icons per action type (create, move, comment, etc.)
- [ ] **Time format** — "2 hours ago", "just now" displays correctly

### 1.6 Stats Bar
- [ ] **Counters** — completed / in-progress / new tasks / active agents show real numbers
- [ ] **Non-zero** — at least some stats are > 0

> ✅ **Phase 1 Pass Criteria**: All items checked. No console errors. No blank pages.

---

## Phase 2: Integration Test 🔗

Verify that dashboard ↔ Convex ↔ VPS communication is intact.

### 2.1 Convex Real-time Sync
- [ ] **Two-tab test**: Open dashboard in 2 browser tabs
  1. Tab A: Create a new task
  2. Tab B: Task appears within 1-2 seconds **without refresh**
  3. Tab A: Move the task to a different column
  4. Tab B: Task position updates in real-time
- [ ] **Data persistence**: Refresh both tabs → task still exists in new position

### 2.2 VPS Agent Runtime
Run these on VPS (`ssh fight-uno`):
```bash
# Check PM2 processes
pm2 list

# Check agent heartbeat logs (last 20 lines)
pm2 logs --lines 20

# Verify Convex connection
curl -s https://ceaseless-bullfrog-373.convex.cloud/.well-known/openid-configuration | head -5
```
- [ ] **PM2 running** — agent processes are online
- [ ] **Heartbeat logs** — no recurring errors, agents polling successfully
- [ ] **Convex reachable** — returns JSON response from VPS

### 2.3 Monorepo <> VPS Sync
```bash
# On VPS
ssh fight-uno "cd /home/vforvaick/.openclaw/mission-control && git log --oneline -3"
```
- [ ] **Latest commits** — VPS has the same latest commits as GitHub

### 2.4 Telegram Bot (if active)
- [ ] **Send `/status`** to the bot → responds with agent status
- [ ] **No error spam** — check bot logs for repeated errors

> ✅ **Phase 2 Pass Criteria**: Real-time sync works. VPS agents are heartbeating. Telegram responds.

---

## Phase 3: Turing Test 🤖

Verify agent intelligence and task execution loop.

### 3.1 Basic Communication
- [ ] **Ping Lelouch** via Telegram: send a casual message
  - Expected: Responds in character (strategic, commanding tone)
  - Check: Response arrives within 30s
- [ ] **Ping C.C.** (if chat-enabled): send "status report"
  - Expected: Responds with analytical summary

### 3.2 Task Assignment
- [ ] **Create task via Telegram**: Tell Lelouch "Create a task: Review monorepo deployment status"
  - Check Kanban board: task appears
  - Check: Assigned to appropriate agent
- [ ] **Task decomposition**: Tell Lelouch "Plan a security audit for the dashboard"
  - Expected: Creates parent task + subtasks
  - Check: Subtasks visible under parent in board

### 3.3 Agent Autonomy
- [ ] **Heartbeat cycle**: Wait for one full heartbeat cycle (~10 min for Lelouch)
  - Check `pm2 logs`: agent processes its queue
  - Check Convex: task statuses update
- [ ] **Context retention**: Ask Lelouch "What was the last task you completed?"
  - Expected: References actual task from system

> ✅ **Phase 3 Pass Criteria**: Agent responds in character. Tasks created end-to-end. Heartbeat cycle completes.

---

## Results

| Phase | Status | Notes |
|-------|--------|-------|
| 1. Smoke Test | ⬜ Pending | |
| 2. Integration Test | ⬜ Pending | |
| 3. Turing Test | ⬜ Pending | |

**Overall**: ⬜ Pending

> Update this table as you complete each phase. Mark ✅ Pass, ⚠️ Partial, or ❌ Fail.
