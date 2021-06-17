# Small Task
日々の業務を管理するタスク管理サイトです。
レスポンシブ対応しているのでスマホからもご確認いただけます。

# 使用技術
* Ruby 2.7.3
* Ruby on Rails 6.1.3.2
* MySQL
* Nginx
* Unicorn
* AWS
  * VPC
  * EC2
  * RDS
* Docker/Docker-compose
* CircleCi
* Capistrano3
* Rspec
* Rubocop

# AWS構成図
![AWS](https://user-images.githubusercontent.com/77623090/122341415-673fde80-cf7e-11eb-88bf-4c2d92dcd45f.png)

## CircleCi
  * Githubへのpush時に、RspecとRubocopが自動で実行されます。


# 機能一覧
* ユーザー登録、ログイン機能
* ゲストログイン機能
* 記事詳細表示機能
* 記事投稿機能
* 画像ファイルのアップロード機能
* DBテーブルのリレーション機能
* コメント機能
* ページネーション機能

## テスト
* Rspec
  * 単体テスト機能
  * 統合テスト機能
