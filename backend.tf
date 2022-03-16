# Please keep in mind to set the three environment variables AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_S3_ENDPOINT
terraform {
  backend "s3" {
    bucket = "timon-testing"
    key = "terraform.tfstate"
    region = "main"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
  }
}
