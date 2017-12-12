require 'rest-client'
require 'json'
require 'pry'


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
# binding.pry
def get_movie_info(character)


end

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
end

def search_results(character)
  return_array = []
  character_hash = get_character_movies_from_api(character)
  character_hash["results"].each do |hash|
    if hash["name"].downcase == character
      hash["films"].each do |film_link|
        character_films = RestClient.get(film_link.to_s)
        parse_character_films =  JSON.parse(character_films)
        return_array << parse_character_films
        end
      end
    end
    return_array
end




# WORKING FUNCTION
# def get_character_movies_from_api(character)
#   #make the web request
#   all_characters = RestClient.get('http://www.swapi.co/api/people/')
#   character_hash = JSON.parse(all_characters)
#   return_array = []
#   character_hash["results"].each do |hash|
#
#     if hash["name"].downcase == character
#       hash["films"].each do |film_link|
#         character_films = RestClient.get(film_link.to_s)
#         parse_character_films =  JSON.parse(character_films)
#          return_array << parse_character_films
#         end
#       end
#     end
#   return_array
# end

def parse_character_movies(films_hash)
  films_hash.each do |movie_hash|
    puts movie_hash["title"]
  # some iteration magic and puts out the movies in a nice list
 end
end

def show_character_movies(character)
films_hash = search_results(character)
   parse_character_movies(films_hash)
 end

# WORKING FUNCTION
# def show_character_movies(character)
#   films_hash = get_character_movies_from_api(character)
#   parse_character_movies(films_hash)
# end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
