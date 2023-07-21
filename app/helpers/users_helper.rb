module UsersHelper
  def profile_image(user)
    image_tag("http://secure.gravatar.com/avatar/#{user.gravatar_id}", alt: user.name)
  end

  def profile_image_round(user)
    image_tag("http://secure.gravatar.com/avatar/#{user.gravatar_id}", alt: user.name, class: "h-12 w-12 flex-none rounded-full bg-gray-50")
  end
end
