module ApplicationHelper
	def gravatar_for(user)

		# if user.avatar?
		# 	image_tag user.avatar
		# else
			gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
			gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=80"
			image_tag gravatar_url, alt: user.name, class: 'img-circle'
		#end	
	end
end
