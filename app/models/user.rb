class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreigen_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreigen_key: "followed_id", dependent: :destroy
  #複数のfo架空のテーブルを所持、Reクラスを参照、外部キーfoカラム
  #フォローしている人
  #フォローされている人
  has_many :following_users, through: :active_relationships, source: :followed
  has_many :follower_users, through: :passive_relationships, source: :follower
  #自分がフォローしている人
  #自分をフォローしている人
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    following_users.include?(user)
  end
end
