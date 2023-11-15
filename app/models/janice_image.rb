require 'active_record'

ActiveRecord::Base.establish_connection( 
 :adapter => "mysql2",
 :host => "Gordons-Laptop.local",
 :username=>"root",
 :password=>"@Gordonjanice022217!",
 :database => "chrome_extension"
)

class JaniceImage < ActiveRecord::Base
    has_many :table_relationship
end

# puts JaniceImage.all
