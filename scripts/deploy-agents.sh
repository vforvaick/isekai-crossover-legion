#!/bin/bash
# Deploy agents package to VPS fight-uno

set -e

echo "🚀 Deploying Mission Control Agents to VPS..."

# Configuration
VPS_HOST="fight-uno"
VPS_PATH="/home/vforvaick/.openclaw/mission-control"
LOCAL_PATH="packages/agents"

# Check if agents package exists
if [ ! -d "$LOCAL_PATH" ]; then
    echo "❌ Error: $LOCAL_PATH directory not found"
    echo "   Agent package not yet implemented"
    exit 1
fi

#Sync agents package
echo "📦 Syncing $LOCAL_PATH to $VPS_HOST:$VPS_PATH..."
rsync -avz --delete \
    --exclude 'node_modules' \
    --exclude '.git' \
    "$LOCAL_PATH/" "$VPS_HOST:$VPS_PATH/packages/agents/"

# Install dependencies and restart PM2
echo "📥 Installing dependencies on VPS..."
ssh "$VPS_HOST" << 'ENDSSH'
    cd /home/vforvaick/.openclaw/mission-control/packages/agents
    npm install
    
    echo "🔄 Restarting PM2 processes..."
    pm2 restart all
    
    echo "✅ Deployment complete!"
    pm2 list
ENDSSH

echo "🎉 Agents deployed successfully!"
