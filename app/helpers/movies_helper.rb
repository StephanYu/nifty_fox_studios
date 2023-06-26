module MoviesHelper
  def average_stars(movie)
    if movie.average_stars.zero?
      content_tag(:strong, "No reviews")
    else
      "*" * movie.average_stars.round
    end
  end

  def main_image(movie)
    if movie.main_image.attached?
      image_tag(movie.main_image, class: "h-full w-full object-cover object-center lg:h-full lg:w-full")
    elsif movie.image_url.present?
      image_tag(movie.image_url, class: "h-full w-full object-cover object-center lg:h-full lg:w-full")
    else
      image_tag("placeholder.png", class: "h-full w-full object-cover object-center lg:h-full lg:w-full")
    end
  end
end
  