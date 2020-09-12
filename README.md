# README
<h1>SNS風API</h1>

# 機能
## ユーザー登録/JWT認証
## 投稿機能
## いいね機能
## コメント機能
## フォロー機能

# やること

# Model 

User
-email
-password_digest
-name
-profile_image
-introduction

Post
-user
-text
-image

Like
-user
-post

Comment
-user
-post
-text

Follow
-follower_id
-followed_id

