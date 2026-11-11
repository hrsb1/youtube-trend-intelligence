# YouTube Data Engineering Pipeline on AWS

A production-grade serverless data lake implementing the Medallion Architecture for ingesting and processing YouTube Trending Data.

## Architecture Overview

```
YouTube API v3 
    ↓
Lambda: Ingestion 
    ↓
S3 Bronze (raw/region=*/date=*)
    ↓
Glue Job: Bronze → Silver
    ↓
S3 Silver (parquet/region=*/date=*)
    ↓
Lambda: Data Quality Validation
    ↓
Glue Job: Silver → Gold
    ↓
S3 Gold (Analytics Tables)
    ↓
Amazon Athena
    ↓
Amazon QuickSight
```

## Tech Stack

- **Data Ingestion**: AWS Lambda + YouTube API v3
- **Storage**: Amazon S3 (Medallion Architecture)
- **ETL/ELT**: AWS Glue (PySpark)
- **Data Quality**: AWS Lambda
- **Orchestration**: AWS Step Functions
- **Query Engine**: Amazon Athena
- **BI Tool**: Amazon QuickSight
- **Notifications**: Amazon SNS
- **IaC**: Terraform
- **Python Libraries**: boto3, googleapiclient, awswrangler, pyspark

## Quick Start

```bash
# 1. Prerequisites
aws configure
aws secretsmanager create-secret --name youtube-api-key --secret-string "YOUR-KEY"

# 2. Configure
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your settings

# 3. Deploy
terraform init
terraform plan
terraform apply

# 4. Test
aws stepfunctions start-execution \
  --state-machine-arn $(terraform output -raw stepfunctions_arn) \
  --input '{"region":"US","date":"2024-01-01"}'
```

## Project Structure

```
├── README.md                   # This file
├── QUICKSTART.md              # 15-minute setup
├── Makefile                   # Common commands
├── lambda/
│   ├── ingestion/             # YouTube API ingestion
│   ├── data_quality/          # Data validation
│   └── config.py              # Configuration
├── glue_jobs/
│   ├── bronze_to_silver.py    # ETL transformation
│   └── silver_to_gold.py      # Analytics aggregation
├── athena/
│   ├── bronze.sql             # Raw data queries
│   ├── silver.sql             # Cleaned data queries
│   └── gold.sql               # Analytics queries
├── step_functions/
│   └── pipeline.json          # Orchestration
├── terraform/
│   ├── variables.tf
│   ├── s3.tf
│   ├── iam.tf
│   ├── lambda.tf
│   ├── glue.tf
│   ├── sns.tf
│   ├── step_functions.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
└── docs/
    ├── deployment.md          # Detailed setup
    ├── testing.md             # Testing guide
    └── cost_analysis.md       # Cost analysis
```

## Monthly Cost Estimate

| Service | Cost |
|---------|------|
| Lambda | $40 |
| Glue | $5 |
| S3 | $2.30 |
| Athena | $5 |
| Step Functions | $25 |
| Other | $1 |
| **Total** | **~$78/month** |

See [docs/cost_analysis.md](docs/cost_analysis.md) for optimization strategies.

## Features

✅ YouTube API v3 Integration  
✅ Multi-region support (6+ regions)  
✅ Medallion Architecture (Bronze → Silver → Gold)  
✅ Automated ETL with Glue  
✅ Data Quality Validation  
✅ Step Functions Orchestration  
✅ SNS Notifications  
✅ CloudWatch Monitoring  
✅ KMS Encryption  
✅ IAM Least Privilege  
✅ S3 Lifecycle Policies  
✅ Athena Analytics Ready  
✅ QuickSight Compatible  

## Documentation

- [QUICKSTART.md](QUICKSTART.md) - Get running in 15 minutes
- [docs/deployment.md](docs/deployment.md) - Complete deployment guide
- [docs/testing.md](docs/testing.md) - Testing procedures
- [docs/cost_analysis.md](docs/cost_analysis.md) - Cost estimation & optimization

## Usage

```bash
# View available commands
make help

# Deploy infrastructure
make deploy

# Test pipeline
make lambda-invoke

# Monitor logs
aws logs tail /aws/lambda/youtube-data-pipeline-prod-ingestion --follow

# Query data with Athena
aws athena start-query-execution \
  --query-string "SELECT * FROM gold.trending_analytics LIMIT 10;" \
  --query-execution-context Database=youtube_pipeline \
  --result-configuration OutputLocation=s3://youtube-athena-results/
```

## Support

For issues and questions, refer to:
- [docs/deployment.md](docs/deployment.md) for setup issues
- [docs/testing.md](docs/testing.md) for testing help
- [docs/cost_analysis.md](docs/cost_analysis.md) for cost questions

---

**Status**: Production Ready | **Version**: 1.0 | **License**: MIT
