class Tag < ActiveRecord::Base
	has_many :tag_relations
	has_many :users, :through => :tag_relations
end
