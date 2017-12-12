require 'rest-client'
require 'json'
require 'pry'

def search_page(character, url='http://www.swapi.co/api/people/')
  if !url
    puts "No #{character} character in star wars universe!"
    return []
  end

  all_characters = RestClient.get(url)
  character_hash = JSON.parse(all_characters)
  character_hash["results"].each do |element|
    if element["name"].downcase == character.downcase
      film_urls = element["films"]
      movies = film_urls.collect {|movie| JSON.parse(RestClient.get(movie))}
      return movies
    end
  end
  puts "char not on this page"
  next_page = character_hash["next"]
  return search_page(character, next_page)
end


def get_character_movies_from_api(character)
  search_page(character)
end

def parse_character_movies(films_hash)
  films_hash.map do |ele|
    ele["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
