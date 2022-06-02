Dir["lib/*.rb"].each { |file| require_relative file }

NewOrLoad.new
