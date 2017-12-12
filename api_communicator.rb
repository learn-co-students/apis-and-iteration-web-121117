require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  next_page = "http://www.swapi.co/api/people/?page=1"
  while next_page
    all_characters = RestClient.get(next_page)
    character_hash = JSON.parse(all_characters)
    character_hash["results"].each do |char_hash|
      if char_hash["name"].downcase == character
        return char_hash["films"]
      end
    end
    next_page = character_hash["next"]
  end
  # puts "Char not found!"
end

def parse_character_movies(films_array)
  films_array.each_with_index do |element,i|

    current_film = RestClient.get(films_array[i])

    film_details = JSON.parse(current_film)
    film_details.each do |key,value|

      if key == "title"
      puts value
      end
    end
  end
end

def char_loop
  character = get_character_from_user
  get_character_movies_from_api(character)
  show_character_movies(character)
end


def show_character_movies(character)
  films_array = get_character_movies_from_api(character)

  if character == "exit"
    puts "May the force be with you, goodbye!"
  elsif
    films_array == nil
    puts "Char not valid!"
    char_loop
  else
    parse_character_movies(films_array)
    char_loop
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
