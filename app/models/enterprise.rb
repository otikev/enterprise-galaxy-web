class Enterprise < ApplicationRecord
	attr_accessor :activation_token
	before_save :downcase_email
	before_create :create_activation_digest


	# Returns the hash digest of the given string.
	def Enterprise.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	
	# Returns a random token.
	def Enterprise.new_token
		SecureRandom.urlsafe_base64
	end

	# Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	private

	def downcase_email
		contact_email.downcase
	end

	def create_activation_digest
		self.activation_token = Enterprise.new_token
		self.activation_digest = Enterprise.digest(activation_token)
	end

end
