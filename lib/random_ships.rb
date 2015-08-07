module Randomships

  def randomly_place_ships game
    @ship_types = [:submarine, :destroyer, :cruiser, :battleship, :aircraft_carrier]
    available_coordinates = build_grid

    until game.player_2.board.ships.count == 5 do
      begin
        ship_type = @ship_types.first
        ship = create_ship(ship_type)
        random_coordinate = available_coordinates.sample
        random_orientation = [:horizontally, :vertically].sample

        game.player_2.place_ship(ship, random_coordinate, random_orientation)

        # don't need to remove coordinate from array, actually. But better because it's faster?
        remove_ship_and_coordinate_from_loop(available_coordinates, random_coordinate)
        
      rescue RuntimeError
        retry
      end
    end
  end


  private

  def remove_ship_and_coordinate_from_loop available_coordinates, random_coordinate
    @ship_types.shift
    coordinate_index = available_coordinates.index{|i| i == random_coordinate}
    available_coordinates.slice!(coordinate_index)
  end

  def create_ship ship_type
    return Ship.submarine         if ship_type == :submarine
    return Ship.destroyer         if ship_type == :destroyer
    return Ship.cruiser           if ship_type == :cruiser
    return Ship.battleship        if ship_type == :battleship
    return Ship.aircraft_carrier  if ship_type == :aircraft_carrier
  end

  def build_grid
    grid = []
    letters = letter_generator
    generate_coordinates(letters, grid)

    grid
  end

  def letter_generator size = Board::SIZE
    letters = []
    letter = "A"
    size.times do
      letters << letter
      letter = letter.next
    end

    letters
  end

  def generate_coordinates letters, grid, size = Board::SIZE
    letters.each do |letter|
      x = 1
      size.times do 
        grid << ((letter + x.to_s).to_sym)
        x += 1
      end
    end
  end

end