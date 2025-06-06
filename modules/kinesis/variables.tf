variable "stream_name" {
  description = "Kinesis Data Stream の名前"
  type        = string
}

variable "shard_count" {
  description = "Kinesis Data Stream のシャード数"
  type        = number
  default     = 1
}

variable "retention_period" {
  description = "Kinesis Data Stream の保持期間（時間単位）"
  type        = number
  default     = 24
}
