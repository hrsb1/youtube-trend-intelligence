# 🚀 Deployment Guide for Your GitHub Repository

## Issue Encountered

The SSH key on this machine is configured for a different GitHub account (`hr2523-fr`), but you want to push to your account (`hrsb1/youtube-trend-intelligence`).

## ✅ Solution: Push to Your Repository

You have **3 options** to authenticate and push:

---

## Option 1: Use Personal Access Token (RECOMMENDED)

### Step 1: Create a GitHub Personal Access Token

1. Go to: https://github.com/settings/tokens
2. Click **Generate new token (classic)**
3. Set **Expiration**: No expiration (or your preference)
4. Select scopes:
   - ✓ repo (full access to repositories)
5. Click **Generate token**
6. Copy the token (you won't see it again!)

### Step 2: Use Token for Authentication

```bash
cd /Users/2523963/YOUTUBE

# Update remote URL to use HTTPS with token
git remote set-url origin https://<YOUR_USERNAME>:<TOKEN>@github.com/hrsb1/youtube-trend-intelligence.git

# Replace:
# <YOUR_USERNAME> = hrsb1
# <TOKEN> = the token you just created

# Example:
git remote set-url origin https://hrsb1:ghp_xxxxxxxxxxxxx@github.com/hrsb1/youtube-trend-intelligence.git

# Push to GitHub
git push -u origin main
```

---

## Option 2: Configure Git Credentials

### Step 1: Set Git Credentials Cache

```bash
# Tell git to remember your credentials for 1 hour
git config --global credential.helper osxkeychain

# Or globally store credentials
git config --global credential.helper store
```

### Step 2: Push (and enter credentials when prompted)

```bash
cd /Users/2523963/YOUTUBE

# Change remote back to HTTPS
git remote set-url origin https://github.com/hrsb1/youtube-trend-intelligence.git

# Push - you'll be prompted for GitHub username and password/token
git push -u origin main
```

When prompted:
- **Username**: hrsb1
- **Password**: Use your GitHub personal access token (not your password)

---

## Option 3: Add SSH Key for Your Account

### Step 1: Generate SSH Key for hrsb1 Account

```bash
# Generate new SSH key with your email
ssh-keygen -t ed25519 -C "hasibur.rahaman@cognizant.com" -f ~/.ssh/id_ed25519_hrsb1

# When prompted for passphrase, press Enter (or set one)
```

### Step 2: Add SSH Key to GitHub

1. Copy your public key:
   ```bash
   cat ~/.ssh/id_ed25519_hrsb1.pub
   ```

2. Go to: https://github.com/settings/keys
3. Click **New SSH key**
4. Title: "MacBook - hrsb1"
5. Paste the key
6. Click **Add SSH key**

### Step 3: Configure SSH Config

Create/edit `~/.ssh/config`:

```bash
Host github.com-hrsb1
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_hrsb1
```

### Step 4: Update Remote and Push

```bash
cd /Users/2523963/YOUTUBE

# Update remote to use the new SSH key
git remote set-url origin git@github.com-hrsb1:hrsb1/youtube-trend-intelligence.git

# Push to GitHub
git push -u origin main
```

---

## 🎯 QUICKEST SOLUTION (Recommended)

### Use This Command (Replace TOKEN):

```bash
cd /Users/2523963/YOUTUBE

# 1. Create token at: https://github.com/settings/tokens
# 2. Run this (replace YOUR_TOKEN):
git remote set-url origin https://hrsb1:YOUR_TOKEN@github.com/hrsb1/youtube-trend-intelligence.git

# 3. Push
git push -u origin main

# 4. Verify
echo "✓ Check: https://github.com/hrsb1/youtube-trend-intelligence"
```

---

## ✅ Verify Push Success

After pushing, verify:

```bash
# Check local status
git status

# Should show: "On branch main, nothing to commit"

# Check log
git log --oneline

# Check remote
git remote -v
```

Then visit: **https://github.com/hrsb1/youtube-trend-intelligence**

You should see all the files!

---

## 📋 Files Ready to Push

Your repository will contain:

```
youtube-trend-intelligence/
├── README.md                       Main documentation
├── QUICKSTART.md                  15-minute setup
├── SETUP_INSTRUCTIONS.txt         Detailed setup
├── PROJECT_SUMMARY.txt            Project overview
├── GITHUB_PROJECT_ANALYSIS.md     Repository analysis
├── Makefile                       Common commands
├── .gitignore                     Git configuration
│
├── lambda/                        Lambda functions
│   ├── ingestion/                YouTube API ingestion
│   │   ├── lambda_function.py    (450+ lines)
│   │   └── requirements.txt
│   ├── data_quality/             Data validation
│   │   ├── lambda_function.py    (400+ lines)
│   │   └── requirements.txt
│   └── config.py                 Configuration
│
├── glue_jobs/                     Glue ETL jobs
│   ├── bronze_to_silver.py       (400+ lines)
│   └── silver_to_gold.py         (350+ lines)
│
├── athena/                        SQL queries
│   ├── bronze.sql                (100+ lines)
│   ├── silver.sql                (200+ lines)
│   └── gold.sql                  (500+ lines)
│
├── step_functions/               Orchestration
│   └── pipeline.json             (200+ lines)
│
├── iam/                          IAM policies
│   ├── lambda_policy.json
│   ├── glue_policy.json
│   └── stepfunctions_policy.json
│
├── terraform/                    Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   ├── s3.tf
│   ├── iam.tf
│   ├── lambda.tf
│   ├── glue.tf
│   ├── sns.tf
│   ├── step_functions.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
│
└── docs/                         Documentation
    ├── deployment.md
    ├── testing.md
    └── cost_analysis.md
```

**Total: 50+ files, 5,800+ lines of production code**

---

## 🔄 Post-Push Steps

After successfully pushing:

1. **Verify on GitHub**
   ```
   https://github.com/hrsb1/youtube-trend-intelligence
   ```

2. **Update Repository Description** (Optional)
   - Go to repository settings
   - Add description: "Production-grade YouTube data engineering pipeline with Medallion Architecture, AWS Lambda/Glue/Step Functions, and comprehensive analytics"

3. **Add Topics** (Optional)
   - Tags: `data-engineering`, `aws`, `terraform`, `youtube-api`, `etl`, `medallion-architecture`

4. **Enable GitHub Pages** (Optional)
   - For documentation hosting

---

## 💡 Need Help?

### GitHub Authentication Issues?

```bash
# Reset git credentials (macOS)
git credential-osxkeychain erase
host=github.com
protocol=https
# Press Ctrl+D twice

# Then retry push - it will prompt for new credentials
```

### SSH Key Issues?

```bash
# Test SSH connection
ssh -T git@github.com

# Should return: "Hi hrsb1! You've successfully authenticated..."
```

### Still Stuck?

1. Verify repository exists: https://github.com/hrsb1/youtube-trend-intelligence
2. Check you have write access to the repository
3. Verify your GitHub account is configured correctly
4. Try creating a personal access token (most reliable method)

---

## 🎯 Next: AWS Deployment

Once pushed to GitHub:

1. Read `QUICKSTART.md` for 15-minute AWS setup
2. Follow `docs/deployment.md` for detailed instructions
3. Run:
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

---

**Status**: Code is committed locally and ready to push ✓  
**Next**: Choose authentication method above and push  
**Then**: Deploy to AWS  

Choose Option 1 (Personal Access Token) - it's the fastest! ⚡
