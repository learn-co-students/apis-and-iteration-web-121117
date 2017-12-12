require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  current_char = []
  idx = 1
  while current_char == []
    all_characters = RestClient.get("https://www.swapi.co/api/people/?page=#{idx}")
    character_hash = JSON.parse(all_characters)
    current_char = find_char(character_hash, character)
    idx += 1
    if character_hash["next"] == nil
      break
    end
  end
    if current_char != []
      current_char[0]["films"]
    else
      return []
  end
end

def find_char(character_hash, character)
  character_hash["results"].select do |currentCharacter|
    currentCharacter["name"].downcase == character
  end
end

def parse_character_movies(films_hash)
  films_hash.map do |film|
    filmHash = RestClient.get(film)
    JSON.parse(filmHash)
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash == []
    puts "There was no character found with that name."
    return "There was no character found with that name."
  else
    info = parse_character_movies(films_hash)
    filmsList = []
    info.each do |filmStats|
      filmsList << filmStats["title"]
    end
    end
  puts filmsList
end

#start bonus

def get_movie_info(movie)
  all_movies = RestClient.get('http://www.swapi.co/api/films/')
  movie_hash = JSON.parse(all_movies)
  current_movie = find_movie(movie_hash, movie)
  if current_movie == []
    puts "This is not a movie."
    return ""
  else
    current_movie[0].each do |key, value|
      puts "#{key}: #{value}"
    end
  end
end

def find_movie(movie_hash, movie)
  selectedMovie = movie_hash['results'].select do |current_movie|
    #binding.pry
    current_movie['title'].downcase == movie
  end
end

# BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
