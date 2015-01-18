require 'yaml'
require 'fileutils'

if File.exist?('moviesy.yaml')
    movies = YAML.load_file('moviesy.yaml')
else
    FileUtils.touch ('moviesy.yaml')
    placeholder = {}
    File.open('moviesy.yaml', 'w'){|fo| fo.puts placeholder.to_yaml}
    movies = YAML.load_file('moviesy.yaml')
end

# Loops code

while 1
puts "You can (dis)play, (a)dd, (u)pdate, (del)ete, or e(x)it"
choice = gets.chomp

case choice
# Adds a movie title and rating to a user created list stored in the moviesy.yaml file
when "a"
    puts "What movie would you like to add?"
    title = gets.chomp
    puts "What is the movie's rating?(0-10)"
    rating = gets.chomp
    if movies[title.to_sym].nil?
        movies[title.to_sym] = rating.to_i
        puts "Your Movie And Rating Were Added!"
	File.open('moviesy.yaml', 'w') { |fo| fo.puts movies.to_yaml }
    else
        puts "Error: This movie has already been added."
    end
# Updates an existing movie title's rating
when "u"
    puts "Which movie's rating would you like to update?"
    title = gets.chomp
    if movies[title.to_sym].nil?
        puts "Error: This movie is not currently in the library."
    else
        puts "What is the new rating?(0-10)"
        movies[title.to_sym] = gets.chomp.to_i
	File.open('moviesy.yaml', 'w') { |fo| fo.puts movies.to_yaml }
    end
    puts "Title Updated!"
# Displays movie titles and rating alphabetically
when "dis"
    puts "-----Alphabetically-----"
    movies_sorted = Hash[movies.sort_by{|title, rating| title}]
    movies_sorted.each do |movie, rating|
        puts "#{movie}: #{rating}"
    end
    puts "------------------------"
# Deletes a title and rating
when "del"
    puts "Which movie would you like to delete from the library?"
    td = gets.chomp
    if movies[td.to_sym].nil?
        puts "Error: This movie cannot be deleted because it is not in the library."
    else
        movies.delete(td.to_sym)
        puts "Title Deleted!"
	File.open('moviesy.yaml', 'w') { |fo| fo.puts movies.to_yaml }
    end
# Exits the program
when "x"
    begin
    	exit
    	puts "never get here"
    
    end
else
    puts "Error!"
end
end