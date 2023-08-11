class Sub < ApplicationRecord
    validates_presence_of :title, :moderator_id
    validates_uniqueness_of :title

    belongs_to :moderator
        foreign_key: :moderator_id
        class_name: :User

    has_many :posts
end
