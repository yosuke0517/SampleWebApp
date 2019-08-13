class User < ApplicationRecord
    has_many :authorizations
    has_secure_password(validations: false)
    has_one_attached :image
    #has_many_attached :image
    #before_save { self.email = email.downcase }
    before_save :email_downcase
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false}, unless: :uid?
    validates :password, length: {minimum: 6}, presence: true, confirmation: true, unless: :uid?
    has_many :questions

    def User.create_from_auth!(auth)
      #authの情報を元にユーザー生成の処理を記述
      #auth["credentials"]にアクセストークン、シークレットなどの情報が入ってます。
      #auth["info"]["email"]にユーザーのメールアドレスが入ってます。(Twitterはnil)
        create! do |user|
            #user.provider = auth[:provider]
            user.uid = auth[:uid]
            user.name = auth[:info][:name]
            #user.image = auth[:info][:image]
            user.token = auth[:credentials][:token]
            user.secret = auth[:credentials][:secret]
        end
    end

    def email_downcase
        unless uid?
            self.email.downcase!
        end
    end
end
