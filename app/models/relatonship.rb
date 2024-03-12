class Relatonship < ApplicationRecord

belongs_to :follower, class_name: "User"
belongs_to :followed, class_name: "U"

end
