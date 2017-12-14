#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
users_character_choice = get_character_from_user
show_character_movies(users_character_choice)

# welcome
# users_character_choice = get_character_from_user
# show_character_movies(users_character_choice)
