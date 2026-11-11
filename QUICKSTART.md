# Quick Start Guide - 15 Minutes

Get the YouTube Data Engineering Pipeline running in 15 minutes!

## Prerequisites

- AWS Account
- AWS CLI v2 configured: `aws configure`
- Terraform 1.0+
- YouTube Data API key from [Google Cloud Console](https://console.cloud.google.com/)

## Step 1: Store YouTube API Key (2 min)

```bash
aws secretsmanager create-secret \
  --name youtube-api-key \
  --secret-string "YOUR_YOUTUBE_API_KEY"
```

## Step 2: Configure Terraform (3 min)

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars

# Edit the file - update these:
# 1. sns_notification_email = "your-email@example.com"
# 2. data_bucket_name = "unique-bucket-name-$(date +%s)"
# 3. youtube_regions = ["US", "GB", "DE", "FR", "IN", "JP"]

nano terraform.tfvars
```

## Step 3: Deploy (5 min)

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

## Step 4: Test Pipeline (3 min)

```bash
# Get the state machine ARN
STATE_MACHINE_ARN=$(terraform output -raw stepfunctions_arn)

# Start execution
aws stepfunctions start-execution \
  --state-machine-arn $STATE_MACHINE_ARN \
  --input '{
    "region": "US",
    "date": "2024-01-01"
  }'

# Check status in CloudWatch Logs
aws logs tail /aws/lambda/youtube-data-pipeline-prod-ingestion --follow
```

## Step 5: Verify Data (2 min)

```bash
# List S3 data
aws s3 ls s3://youtube-data-lake-XXXXXXX/bronze/raw/

# Check SNS subscription (confirm email)
```

## Troubleshooting

### S3 bucket already exists?
```bash
# Use unique name in terraform.tfvars:
data_bucket_name = "youtube-data-lake-$(date +%s)"
```

### Permission denied errors?
```bash
# Check AWS credentials
aws sts get-caller-identity
```

### See detailed logs
```bash
terraform show
aws logs tail /aws/lambda/youtube-data-pipeline-prod-* --follow
```

## Common Commands

```bash
make help              # Show all commands
make lambda-invoke     # Test Lambda
make status            # Check pipeline status
make cost-estimate     # View estimated costs
terraform destroy      # Delete all resources
```

## Next Steps

1. ✅ Approve SNS email subscriptions
2. ✅ Query data in Athena (see athena/ folder)
3. ✅ Connect QuickSight for dashboards
4. ✅ Set up CloudWatch budget alarms
5. ✅ Review [docs/deployment.md](docs/deployment.md) for details

## Cost

~$78/month for base setup. See [docs/cost_analysis.md](docs/cost_analysis.md) for optimization.

---

**That's it! Your pipeline is running.** 🚀
