require 'json'
require 'date'

file_path = File.dirname(__FILE__)
file_name = file_path + "/astro.json"

begin
  file = File.read(file_name, encoding: 'utf-8')
rescue
end

astro = JSON.parse(file)
puts "Where are you born? In format DD.MM [25.03]"
date_input = STDIN.gets.chomp

user_birth_date = Date.parse("#{date_input}.2000")

user_sign = nil

astro.each do |key, value|
  dates = value["dates"].split("..")

  dates_left = Date.parse("#{dates[0]}.2000")
  dates_right = Date.parse("#{dates[1]}.2000")

  if (dates_left <= user_birth_date &&
      user_birth_date <= dates_right)
    user_sign = value
    break
  end

  if dates_left > dates_right
    if (user_birth_date >= dates_left &&
        user_birth_date >= dates_right)
      user_sign = value
      break
    elsif (user_birth_date <= dates_left &&
        user_birth_date <= dates_right)
      user_sign = value
      break
    end
  end

end

puts "#{user_sign["dates"]}"
puts "#{user_sign["text"]}"