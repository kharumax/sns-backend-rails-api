class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,:user_id,:context,:image_url
end
