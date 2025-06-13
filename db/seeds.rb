# メインのサンプルユーザーを1人作成する
User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'password',
             password_confirmation: 'password',
             admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name # それっぽい名前
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
# ユーザーの一部を対象にマイクロポストを生成する
# ユーザの集合作成
users = User.order(:created_at).take(6)
# 5文字程度の投稿50個
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end
