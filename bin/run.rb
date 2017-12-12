#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
while true
  character = get_character_from_user
  puts show_character_movies(character)
end
