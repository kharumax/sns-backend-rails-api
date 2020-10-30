class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,:user_id,:post_id,:text
end
