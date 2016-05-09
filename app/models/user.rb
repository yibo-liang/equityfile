class User < ActiveRecord::Base

	attr_accessor :password

	has_many :friends, through: :friendships
	has_many :friendships
	has_many :friendships, :dependent => :destroy

	belongs_to :company
	
	has_many :messages
	has_many :interests
	has_one :additional_detail, :dependent => :destroy

	has_many :tag_relations
	has_many :tags, :through => :tag_relations

	has_many :matches

	has_many :meetings, through: :meeting_instance

	has_many :api_keys


	#Rel for inv to meetings
	has_many :meeting_instances


	before_save :encrypt_password
	validates_presence_of :email, :on => :create
	validates_uniqueness_of :email

	after_create do
		if(self.company.investor)
    		AdditionalDetail.new(user_id: self.id).save
    	end
  	end

	def self.authenticate(details)
		user = find_by_email(details[:email])
		if user && user.password_hash != nil
			if user.password_hash == BCrypt::Engine.hash_secret(details[:password], user.password_salt)
				user
			else
				nil
			end
		end
	end
	def friends
		friends = []
		filtered_friends = []
		User.find(self.id).friendships.each {|a| friends << User.where(id: a.friend_id).select([:id, :firstname, :surname, :email, :username, :created_at])}
		friends.each {|a| filtered_friends << a[0] }

		return filtered_friends
	end
private
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end