output "stream_name" {
  description = "作成された Kinesis Data Stream の名前"
  value       = aws_kinesis_stream.this.name
}

output "stream_arn" {
  description = "作成された Kinesis Data Stream のARN"
  value       = aws_kinesis_stream.this.arn
}
