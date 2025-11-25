output "s3_bucket_name" {
  description = "The name of the S3 bucket used for Terraform state"
  value       = aws_s3_bucket.tf_state.bucket
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table used for Terraform locking"
  value       = aws_dynamodb_table.tf_state_lock.name
}
