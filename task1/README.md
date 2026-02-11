# Creting a VPC

> reference material
> https://spacelift.io/blog/terraform-aws-vpc

## Before anything - setup aws

- for localstack
    - create profile for localstack at `~/.aws/config`
    - add dummy credentials at `~/.aws/credentials`
    - set `AWS_PROFILE` env var to `localstack`
- for terraform
    - create terraform block to require aws provider
    - create provider block to configure aws provider

```
# aws config
[profile localstack]
region = us-east-1
output = json
endpoint_url = http://localhost.localstack.cloud:4566

# aws credentials
[localstack]
aws_access_key_id = test
aws_secret_access_key = test
```

- can run aws cli and terraform commands now
***


