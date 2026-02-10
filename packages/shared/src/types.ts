// Shared TypeScript types for Mission Control
export type AgentStatus = "online" | "working" | "idle" | "sleeping" | "offline";
export type AgentLayer = "strategic" | "analyst" | "lead" | "specialist";
export type TaskStatus = "backlog" | "todo" | "in_progress" | "review" | "done";
export type TaskPriority = "low" | "medium" | "high" | "urgent";

export interface Agent {
    _id: string;
    handle: string;
    name: string;
    role: string;
    layer: AgentLayer;
    status: AgentStatus;
    source?: string;
    emoji?: string;
    skills?: string[];
    dormant?: boolean;
    lastHeartbeat?: number;
}

export interface Task {
    _id: string;
    boardId: string;
    title: string;
    description?: string;
    status: TaskStatus;
    priority: TaskPriority;
    assigneeId?: string;
    tags?: string[];
    dueDate?: number;
}
