Dir["lib/*.rb"].each { |file| require_relative file }
#b = Board.new
#b.grid.map { |e| e.map.with_index { |el, ind| el.symbol unless el.nil?}}.each { |e| p e}
game = Game.new