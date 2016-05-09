class TagRelation < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag
end
