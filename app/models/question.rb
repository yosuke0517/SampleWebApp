class Question < ApplicationRecord
has_many :answers, dependent: :destroy
has_many_attached :images
has_many :likes
has_many :liked_users, through: :likes, source: :user
belongs_to :user
  validates :name, presence: false
  validates :title, presence: true
  validates :content, presence: true

  #検索条件のパラメータとしてtitleとcontentのみ許可する
  def self.ransackable_attributes(auth_object = nil)
    %w[title content]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
