# ——— プロバイダー設定 ———
provider "aws" {
  region = "ap-northeast-1"
}

# ——— Kinesis モジュール呼び出し ———
module "kinesis" {
  source = "../../modules/kinesis"

  # Dev 環境用のストリーム名を自由に決めて OK
  stream_name      = "dev-test-kinesis-stream"
  shard_count      = 1               # 1 シャードで固定
  retention_period = 24              # デフォルト 24 時間
}

# （オプション）ローカルで使いたい場合のデータ送信用 IAM ユーザーやポリシーを追加しても良い
# resource "aws_iam_user" "dev_kinesis_user" { ... }
