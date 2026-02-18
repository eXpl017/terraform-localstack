# Terraform Practice with AWS on Localstack

- This repo is for practicing my terraform and aws skills
- I am using an Ubuntu 24.04 LTS WSL instance for this
- Credentials seen in the repo are left on purpose as they pose no threat and are just placeholders

## Before anything - setup aws

- for localstack
    - create profile for localstack at `~/.aws/config`
    - add dummy credentials at `~/.aws/credentials`
    - set `AWS_PROFILE` env var to `localstack`
- for terraform
    - create terraform block to require aws provider
    - create provider block to configure aws provider

## Terraform CLI Config

- setting up of plugin cache directory
- the need for this was simple - I did not want the same provider file downloading and taking up space
- what I did:
    - set `TF_CLI_CONFIG_FILE` env var to `"${HOME}/terraform-prac/.terraformrc"`
    - create `.terraformrc` in above location, added below mentioned content to it
    - created `.terraform.d/plugin-cache` in the same dir (tf doesn't create automatically, it needs to be present)
- once the above is done, will need to delete the `.terraform/` dirs, and reinitialize the project for provider files to be cached
- by caching, all that happens here is creation of soft links to one place its actually present at

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


# .terraformrc
plugin_cache_dir = "${HOME}/terraform-prac/.terraform.d/plugin-cache"

```

- can run aws cli and terraform commands now
***

