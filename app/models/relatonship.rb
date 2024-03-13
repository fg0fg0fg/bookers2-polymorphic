class Relatonship < ApplicationRecord

belongs_to :follower, class_name: "User"
belongs_to :followed, class_name: "User"
#fo架空のテーブルに所属、Usクラスを参照
#フォローする人
#フォローされる人
end
