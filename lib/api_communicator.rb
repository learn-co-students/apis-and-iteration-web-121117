require 'rest-client'
require 'json'
require 'pry'


def search_page(users_character_choice, url='http://www.swapi.co/api/people/')
  if !url
    puts "#{users_character_choice} is not in Star Wars, silly goose!"
    return []
  end

  all_characters = RestClient.get(url)
  character_hash = JSON.parse(all_characters)
  character_hash["results"].each do |api_hash|
    if api_hash["name"].downcase == users_character_choice.downcase
      film_urls = api_hash["films"]
      films = film_urls.collect {|film| JSON.parse(RestClient.get(film))}
      puts films
    end
  end
  next_page = character_hash["next"]
  return search_page(users_character_choice, next_page)
end


def get_character_movies_from_api(users_character_choice)
  search_page(users_character_choice)
end


def parse_character_movies(films_hash)
  films_hash.collect do |attribute|
    attribute["title"]
  end
end

def show_character_movies(users_character_choice)
  films_hash = get_character_movies_from_api(users_character_choice)
  parse_character_movies(films_hash)
end
