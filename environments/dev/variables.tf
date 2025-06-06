# 今回は環境固有の変数がないため、空ファイルでもかまいません。
# もし将来的にストリーム名だけ上書きしたい場合は、たとえば以下のように書きます:
#
# variable "stream_name" {
#   description = "Dev 環境用の Kinesis Stream 名"
#   type        = string
#   default     = "dev-test-kinesis-stream"
# }
#
# 現状はモジュール側のデフォルト値だけでも動作します。
