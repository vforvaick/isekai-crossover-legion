# Vercel Update Instructions

## Current Status

The monorepo has been successfully deployed to GitHub:
- **Repo**: https://github.com/vforvaick/isekai-crossover-legion
- **Dashboard Package**: `packages/dashboard`

## Required Vercel Updates

### 1. Update Project Settings

1. Go to: https://vercel.com/dashboard
2. Select your project: `mission-control-dashboard`
3. Go to **Settings** → **Git**
4. Update repository:
   - **New Repository**: `vforvaick/isekai-crossover-legion`
   - Click "Connect"

### 2. Configure Build Settings

In **Settings** → **General** → **Build & Development Settings**:

- **Framework Preset**: `Next.js`
- **Root Directory**: `packages/dashboard`
- **Build Command**: `npm run build` (leave default)
- **Output Directory**: `.next` (leave default)
- **Install Command**: `npm install` (leave default, will install workspace deps)

### 3. Environment Variables

Ensure these are set in **Settings** → **Environment Variables**:

- `NEXT_PUBLIC_CONVEX_URL`: `https://ceaseless-bullfrog-373.convex.cloud`
- `CONVEX_DEPLOYMENT`: `prod:ceaseless-bullfrog-373`

(These should already exist from previous deployment)

### 4. Trigger Redeploy

1. Go to **Deployments** tab
2. Click "Redeploy" on the latest deployment
3. Or push any commit to trigger auto-deploy

## Verification

After deployment:
1. Check build logs for errors
2. Visit dashboard URL: https://mission-control-dashboard-amber.vercel.app
3. Verify Convex connection works
4. Test Kanban board functionality

## Troubleshooting

**If build fails**:
- Check that `Root Directory` is set to `packages/dashboard`
- Verify workspace dependencies are installing correctly
- Check build logs for specific errors

**If Convex connection fails**:
- Verify environment variables are set correctly
- Check Convex dashboard for recent activity
