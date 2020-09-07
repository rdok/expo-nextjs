provider "aws" {
  version = "~> 3.0"
  region = var.aws_region
}

terraform {
  required_version = ">= 0.13, < 0.14"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "rdok"

    workspaces {
      prefix = "expo-nextjs-template-"
    }
  }
}


resource "aws_s3_bucket" "static-website-hosting" {
  bucket = "${var.name}-${var.environment}"
  acl = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.name}-${var.environment}/*"
    }]
}
EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name = var.name
    Environment = var.environment
  }
}


output "static-website-endpoint" {
  value = aws_s3_bucket.static-website-hosting.website_endpoint
}
