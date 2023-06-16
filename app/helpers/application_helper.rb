module ApplicationHelper
  def default_img(profile_image)
    profile_image.presence || 'no-image.png'
  end
end
