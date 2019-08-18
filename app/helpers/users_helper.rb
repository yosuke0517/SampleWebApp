module UsersHelper
    def
        gravatar_url(user, options = {size: 80 })
        if user.email.nil?
            user.email = ""
        end
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end
end
