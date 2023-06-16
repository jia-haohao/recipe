module ApplicationHelper
  def default_img(profile_image, image)
    profile_image.presence || image.presence || 'no-image.png'
  end
end
