class User < ApplicationRecord
  has_one :vote
  has_many :requests

  class << self

    # Get user if exists with the reponse params UID from Google from oauth2.
    #
    # * *Args (input)* :
    # - +access_token+ -> Array repsonse from oath.
    #
    # * *Returns (output)* :
    # - user object if was created before.
    # - nil if not exist user by uid.
    #
    def from_omniauth(access_token)
      data = access_token
      user = User.where(uid: data['uid']).first
      user
    end

  end

end
