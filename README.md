個人向け
ToDoリスト

テーブル
**task**
| id | name:string | content:text | limit:date | priority:integer | progress:string | user_id:bigint |
**user**
| id | name:string | email:string | pass:string | pass_digest:string |
**tag**
| id | label:string | task_id:bigint |

リスト
　find_by(progress: )

タスク名検索
?

ソート機能
?

ラベル機能(アソシエーション？)

ユーザー登録・ログイン機能
  本人のタスクのみ表示(セッション)



```
heroku login
heroku create
heroku buildpacks:set heroku/ruby
( heroku buildpacks:add --index 1 heroku/nodejs )
git init
heroku git:remote -a ${ｱﾌﾟﾘ名}
git add .
git commit -am "first"
git push heroku main
	# bundlerの-vが一致しない時
	gem uninstall bundler
	gem install bundler --version '${合わせたい-v}'
	rm gemfile.lock
	bundle _2.2.16_ install
	bundler -v
	bundle lock --add-platform x86_64-linux
	git add -A
	git commit -m "bundler修正"
	git push -u origin ${ﾌﾞﾗﾝﾁ名}
	git push heroku main
heroku run rails db:migrate
```