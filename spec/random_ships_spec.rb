class RandomShipsSpec
  include Randomships
end

  describe RandomShipsSpec do
    describe '#randomly_place_ships' do
      it "places one of each type of ship on player_2's board" do
        game = Game.new Player, Board
        subject.randomly_place_ships game
        puts "PLAYER 2's BOARD AFTER RANDOM PLACING: \n#{game.own_board_view game.player_2}"
        expect(game.player_2.board.ships.count).to eq 5
      end
    end
  end
