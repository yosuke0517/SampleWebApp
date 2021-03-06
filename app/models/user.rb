class User < ApplicationRecord
    has_many :authorizations
    has_secure_password(validations: false)
    has_one_attached :image
    has_many :messages, dependent: :destroy
    has_many :entries, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_questions, through: :likes, source: :question
    #has_many_attached :images
    #before_save { self.email = email.downcase }
    before_save :email_downcase
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false}, unless: :uid?
    validates :password, length: {minimum: 6}, presence: true, confirmation: true, unless: :uid?
    has_many :questions
    has_many :answers
    #自分がフォローしているユーザ
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    #フォローされているユーザ（フォロワーを取得）
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user

    def follow(other_user)
        unless self == other_user
          self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end

    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end

    def following?(other_user)
        self.followings.include?(other_user)
    end

    def already_liked?(question)
        self.likes.exists?(question_id: question.id)
    end

    def User.create_from_auth!(auth)
      #authの情報を元にユーザー生成の処理を記述
      #auth["credentials"]にアクセストークン、シークレットなどの情報が入ってます。
      #auth["info"]["email"]にユーザーのメールアドレスが入ってます。(Twitterはnil)
        create! do |user|
            user.provider = auth[:provider]
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
