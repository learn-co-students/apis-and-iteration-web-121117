require 'rest-client'
require 'json'
require 'pry'
require_relative './command_line_interface.rb'

def correct_hash(character_hash, character)
  character_hash["results"].find do |charhash|
    charhash["name"].downcase == character
  end
end

def get_and_parse(url)
  JSON.parse(RestClient.get(url))
end

def find_character_hash(character)
  character_hash = get_and_parse('http://www.swapi.co/api/people/')
  while correct_hash(character_hash, character) == nil
    if character_hash["next"] == nil
      puts "Come on. That's not a Star Wars character. Run me again."
      abort
    else
      character_hash = get_and_parse(character_hash["next"])
    end
  end
  correct_hash(character_hash, character)
end


def get_character_movies_from_api(character)
  character_hash = find_character_hash(character)
  character_hash["films"].collect do |movieurl|
    get_and_parse(movieurl)
  end
end

  # play around with puts out other info about a given film.

def parse_character_movies(films_hash)
  films_hash.collect do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
