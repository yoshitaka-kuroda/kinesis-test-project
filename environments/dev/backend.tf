terraform {
  backend "s3" {
    bucket = "yoshitaka-terraform-state-bucket"
    key    = "kinesis-test-project/dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
