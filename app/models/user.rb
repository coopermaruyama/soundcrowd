class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :omniauthable
	attr_accessible :email, :password, :password_confirmation, 
									:remember_me, :username, :provider, :uid, :token, :avatar_url
	has_many :user_productions
	has_many :productions, :through => :user_productions
	has_many :versions, :through => :productions
 	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
 	has_many :followed_users, through: :relationships,
 														source:  :followed
 	has_many :reverse_relationships, foreign_key: "followed_id",
 																		class_name: "Relationship",
 																		dependent: :destroy
 	has_many :followers, through: :reverse_relationships, source: :follower
 	has_many :production_follows, :class_name => "ProductionFollower"

 	def self.find_for_soundcloud_oauth(auth, signed_in_resource=nil)
 		user = User.where(:provider => auth.provider, :uid => auth.uid).first
 		unless user
 			user = User.create!(
 				provider: auth.provider,
 				email: "#{auth.uid}@soundcloud.com",
 				uid: auth.uid,
 				username: auth.extra.raw_info.username,
 				password: auth.credentials.token,
 				avatar_url: auth.extra.raw_info.avatar_url,
 				token: auth.credentials.token
 				)
 		end
 		user
 	end

 	def following?(other_user)
 		relationships.find_by_followed_id(other_user.id)
 	end

 	def follow!(other_user)
 		relationships.create!(followed_id: other_user.id)	
 	end

 	def unfollow! (other_user)
 		relationships.find_by_followed_id(other_user.id).destroy
 	end

 	def following_production?(production)
 		production_follows.find_by_production_id(production.id)
 	end

 	def follow_production!(production)
 		production_follows.create!(production_id: production.id)	
 	end

 	def unfollow_production! (production)
 		production_follows.find_by_production_id(production.id).destroy
 	end
 	
end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  username               :string(255)
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

