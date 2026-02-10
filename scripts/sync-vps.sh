#!/bin/bash
# Sync latest code from GitHub to VPS

set -e

echo "🔄 Syncing latest code to VPS fight-uno..."

VPS_HOST="fight-uno"
VPS_PATH="/home/vforvaick/.openclaw/mission-control"

ssh "$VPS_HOST" << 'ENDSSH'
    cd /home/vforvaick/.openclaw/mission-control
    
    echo "📥 Pulling latest from GitHub..."
    git pull origin main
    
    echo "📦 Installing dependencies..."
    npm install
    
    echo "🔄 Restarting PM2 processes..."
    pm2 restart all
    
    echo "✅ Sync complete!"
    git log --oneline -1
    pm2 list
ENDSSH

echo "🎉 VPS synchronized successfully!"
