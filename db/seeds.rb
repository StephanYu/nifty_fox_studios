# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 1. Fetch the data from the IMDB-Top-100 API
require 'uri'
require 'net/http'

url = URI(Rails.application.credentials.dig(:rapidapi, :imdb100_url))

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["X-RapidAPI-Key"] = Rails.application.credentials.dig(:rapidapi, :imdb100_key)
request["X-RapidAPI-Host"] = Rails.application.credentials.dig(:rapidapi, :imdb100_host)

response = http.request(request)
if response.code != "200"
  puts "Error: #{response.code}"
  exit
else
  puts "Success: #{response.code}"
end

movies = JSON.parse(response.read_body)
puts "Total Movies downloaded: #{movies.count}"
# 2. Create a new movie record for each movie in the API response
# Example movie record:
# rank:1
# title:"The Shawshank Redemption"
# thumbnail:"https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY67_CR0,0,45,67_AL_.jpg"
# rating:"9.3"
# id:"top1"
# year:1994
# image:"https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_QL75_UX380_CR0,1,380,562_.jpg"
# description:"Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency."
# trailer:"https://www.youtube.com/embed/NmzuHjWmXOc"
# genre:
# 0:"Drama"
# director:
# 0:"Frank Darabont"
# writers:
# 0:"Stephen King (based on the short novel "Rita Hayworth and the Shawshank Redemption" by)"
# 1:"Frank Darabont (screenplay by)"
# imdbid:"tt0111161"
begin
  puts "Creating movies..."
  movies.each_with_index do |movie, index|
    puts "Creating movie #{index + 1}: #{movie["title"]}"

    movie = Movie.new({
      title: movie.dig("title"),
      description: Faker::Lorem.paragraph(sentence_count: 5),
      release_year: movie.dig("year"),
      rating: movie.dig("rating"),
      genre: movie.dig("genre", 0),
      rank: movie.dig("rank"),
      image_thumbnail_url: movie.dig("thumbnail"),
      image_url: movie.dig("image"),
    })
    if movie.save!
      puts "Movie #{movie.title} created!"
      puts "Downloading main image for #{movie.title}..."
      main_image = URI.open(movie.image_url)
      file_name = "#{movie.slug}.jpg"
      puts "Attaching main image for #{movie.title} with file_name #{file_name}..."
      movie.main_image.attach(io: main_image, filename: file_name)
    end
  end

  User.create!(name: 'Adam', email: 'test@email.com', password: 'password', password_confirmation: 'password')

  (1..20).each do |index|
    puts "Creating reviews for movie 1..."
    review = Review.new(stars: rand(1..5), comment: Faker::Lorem.paragraph(sentence_count: 2), movie_id: 1, user_id: 1)
    if review.save!
      puts "Review #{review.id} created!"
    end
  end
rescue => exception
  puts "Error: #{exception.message}"
end
