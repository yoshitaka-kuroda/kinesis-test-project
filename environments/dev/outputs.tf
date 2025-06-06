output "kinesis_stream_name" {
  description = "Dev 環境で作成された Kinesis Stream の名前"
  value       = module.kinesis.stream_name
}

output "kinesis_stream_arn" {
  description = "Dev 環境で作成された Kinesis Stream のARN"
  value       = module.kinesis.stream_arn
}
