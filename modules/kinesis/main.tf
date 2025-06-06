resource "aws_kinesis_stream" "this" {
  name             = var.stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_period

  # 修正不要：デフォルトで、シャードが 1 の場合は 24 時間保持です
  # 追加設定があればここに記入してください
}
