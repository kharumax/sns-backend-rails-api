class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,:name,:profile_image,:introduction,:avatar_url

end
