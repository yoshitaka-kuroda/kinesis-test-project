## 概要
Terraform を使い、AWS 上に最小構成の Kinesis Data Stream を作成・動作確認し、最後に削除するサンプルプロジェクトです。  

---

## ディレクトリ構成
```
kinesis-test-project/
├── environments/ # 環境ごとの Terraform 実行用ファイルを格納
│ └── dev/
│ ├── backend.tf # Terraform state（状態管理ファイル）を S3 バケットで管理する設定
│ ├── main.tf # modules/kinesis を呼び出し、Kinesis Stream を定義
│ ├── outputs.tf # apply 後に出力したい値（Stream 名や ARN）を定義
│ └── variables.tf # main.tf で使う変数（今回は空）
├── modules/ # 再利用可能なモジュール群
│ └── kinesis/
│ ├── main.tf # aws_kinesis_stream リソースを定義
│ ├── outputs.tf # stream_name や stream_arn を出力定義
│ └── variables.tf # stream_name, shard_count, retention_period などの変数定義
├── .gitignore # Git 除外ファイル
└── README.md # このファイル
```
yaml
コピーする
編集する

---

## 初期化・実行手順

以下の手順を実行すると、まず「dev-test-kinesis-stream」という名前の Kinesis Data Stream が作成されます。  
その後、AWS CLI でサンプルレコードを送信し、最後に Terraform でストリームを削除します。

### 1. `dev` ディレクトリへ移動
```bash
cd kinesis-test-project/environments/dev
2. Terraform 初期化
bash
コピーする
編集する
terraform init
modules/kinesis のコードを参照して AWS プロバイダーをダウンロード

backend.tf の内容を読み込み、S3 バケットを使ったリモートステートを初期化

3. 設定ファイルの検証（任意）
bash
コピーする
編集する
terraform validate
.tf ファイルの文法チェック・参照モジュールの整合性チェック

4. 実行計画の確認
bash
コピーする
編集する
terraform plan -out=tfplan.out
どのリソースが作成されるかを事前に確認し、tfplan.out に保存

5. リソースの作成
bash
コピーする
編集する
terraform apply tfplan.out
dev-test-kinesis-stream（シャード１本）の Kinesis Stream が AWS 上に作成されます

動作確認（AWS CLI でレコードを送信）
リソース作成後、以下のコマンドをローカル端末（VSCode のターミナルなど）で実行し、ストリームにサンプルデータを投入します。

bash
コピーする
編集する
aws kinesis put-record \
  --stream-name dev-test-kinesis-stream \
  --partition-key "testKey" \
  --data "HelloKinesis" \
  --region ap-northeast-1
ShardId と SequenceNumber が返ってくれば正常にレコードが投入されています。

破棄（コスト削減のため忘れずに！）
テストが終わったら、必ずリソースを削除して課金を最小限に抑えましょう。

bash
コピーする
編集する
terraform destroy -auto-approve
dev-test-kinesis-stream が削除されます

削除後に再度 aws kinesis describe-stream --stream-name dev-test-kinesis-stream を実行すると ResourceNotFoundException が返ります

バックエンド（状態管理）
Terraform の状態管理ファイル（tfstate）は、以下の S3 バケットで一元管理しています。

ini
コピーする
編集する
bucket = "yoshitaka-terraform-state-bucket"  
key    = "kinesis-test-project/dev/terraform.tfstate"  
region = "ap-northeast-1"
Outputs
terraform apply もしくは terraform output で以下を確認できます。

kinesis_stream_name
作成された Kinesis Stream の名前（例: dev-test-kinesis-stream）

kinesis_stream_arn
作成された Kinesis Stream の ARN（例: arn:aws:kinesis:ap-northeast-1:123456789012:stream/dev-test-kinesis-stream）

使用例まとめ
bash
コピーする
編集する
# プロジェクトルートから実行例
cd kinesis-test-project/environments/dev

terraform init                   # 初期化
terraform validate               # (推奨) 構文チェック
terraform plan -out=tfplan.out   # 実行計画を確認
terraform apply tfplan.out       # Kinesis Stream を作成

# AWS CLI でレコードを投入
aws kinesis put-record \
  --stream-name dev-test-kinesis-stream \
  --partition-key "testKey" \
  --data "HelloKinesis" \
  --region ap-northeast-1

# テスト後はリソースを破棄
terraform destroy -auto-approve
