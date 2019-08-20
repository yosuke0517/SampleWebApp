# ポートフォリオ説明
# システム構成図（赤枠部は未実装、9月以降実装予定）
![Imgur](https://i.imgur.com/p02UOoJ.png)

# 技術スタック
- ruby: 2.6.1
- ruby on rails: 5.2.1
- Docker: 19.03.1
- Circleci（CI/CDパイプライン構築）
- AWS(ECR,ECS,EC2,RDS,Route53,S3(ログ、画像))
- Terraform: 0.11.13

### Q&A風サービス
### 実装済みの機能
- 質問・回答の投稿
- 質問の検索機能(gem: ransack)
- ログイン（gemなし)
- 外部サービスログイン(twitterのみ)
- 質問の編集・削除（自分の質問のみ）
- プロフィール画像投稿
- フォロー・フォロワー機能
- マイページ機能
  - ID（メールアドレス）
  - 過去の自分の質問表示
  - フォロー・フォロワー表示

### 機能追加予定
- 質問記事への画像投稿
- パスワード再設定（忘れた場合）...(deviseで検討中）
- twitter、googleでの外部サービスログイン(omniauth)
  - フレンドリーフォワーディングができていないので実装する（優先度低）
  - 複数アカウントの情報が取れてしまった時の画像のアタッチ
- いいね機能
- 管理画面(ActiveAdmin)
- 注目質問（バズり）ランキング表示機能
- DM機能(チャット機能)
- ssl化...serviceを新しく定義し直さないといけない。紐付くロードバランサをhttps用に変える。（ロードバランサの定義は最初に決めて変更できない）

- 2019/08/19現在、非機能要件に注力していたため2019/08/30までに機能追加予定※機能追加予定参照

