個人向け
ToDoリスト

テーブル
**task**
| id | name:string | limit:date | priority:integer | progress:string | user_id:bigint |
**user**
| id | name:string | email:string | pass:string | pass_digest:string |
**tag**
| id | name:string | task_id:bigint |

リスト
　find_by(progress: )

タスク名検索
?

ソート機能
?

ラベル機能(アソシエーション？)

ユーザー登録・ログイン機能
  本人のタスクのみ表示(セッション)



