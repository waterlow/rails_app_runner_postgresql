# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)

first_names = %w[蒼 凪 蓮 陽翔 湊 陽葵 凛 詩 陽菜 結菜]
last_names = %w[佐藤 鈴木 高橋 田中 伊藤 渡辺 山本 中村 小林 加藤]
# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = "#{last_names.sample}#{first_names.sample}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

text_list = [
  '私はたいへんいい実験をしたいとさっき考えていたのさ標本にするんですかええ、毎日注文があります。',
  'そうすると、台の下に来ていました。',
  'ああ、そうだ、今夜ケンタウル祭だねえああ、十一時かっきりには着くんだよ男の子が言いました。',
  '風が遠くで鳴り、丘の上を通るようになりながら腰掛にしっかりしがみついていました。',
  'そして青い橄欖の森が、見えない天の川の波も、ときどきちらちら光ってながれているのを見ました。',
  'そのとき汽車はだんだんゆるやかになり、濃い鋼青のそらの野原に、まっすぐにすきっと立ったのです。',
  'いま新しく灼いたばかりの男の子は顔を変にして水の中からでもはいって来るらしいのでした。',
  'その人は赤い眼の下のとこをこすりながら、ジョバンニやカムパネルラのようすを見ていました。',
  'するとちょうど、それにたいへんつかれてねむっていたんだな。',
  '女の子は、いきなり両手を顔にあててしまいました。'
]

users = User.order(:created_at).take(6)
50.times do
  content = text_list.sample([2, 3].sample).join
  users.each do |user|
    time = rand(10).days.ago
    user.microposts.create!(content: content, created_at: time, updated_at: time)
  end
end
