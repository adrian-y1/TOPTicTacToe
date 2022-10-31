# frozen_string_literal: true

require './lib/player'

# 1. Command - Changes the observable state, but does not return a value.
# 2. Query - Returns a result, but does not change the observable state.
# 3. Script - Only calls other methods, usually without returning anything.
# 4. Looping Script - Only calls other methods, usually without returning
#    anything, and stops when certain conditions are met.
describe Player do
  subject(:player_game) { described_class.new }

  describe '#take_turns' do
    # Looping Script -> Test behavior of the method
    # e.g. that it stops when certain conditions are met

    let(:board_turns) { instance_double(Board) }
    subject(:game_turns) { described_class.new(board_turns)}

    before do
      allow(board_turns).to receive(:display)
      allow(game_turns).to receive(:play)
      allow(board_turns).to receive(:winner?)
      allow(board_turns).to receive(:full?)
    end

    it "breaks loop when there's a winner" do
      allow(board_turns).to receive(:winner?).and_return(false, false, false, false, false, true)
      expect(board_turns).to receive(:winner?).exactly(6).times
      game_turns.take_turns
    end

    it "breaks loop when the board is full?" do
      allow(board_turns).to receive(:full?).and_return(false, false, false, false, false, false, false, false, true)
      expect(board_turns).to receive(:full?).exactly(9).times
      game_turns.take_turns
    end
  end

  describe '#play' do
    # Located inside #take_turns method (Looping Script)
    # Public Script Methods -> Only calls other methods
    
    context "when playing a player's turn" do 
      let(:board_place) { instance_double(Board, board: [1, 2, 'X', 4, 5, 6, 7, 8, 9]) }
      subject(:game_place) { described_class.new(board_place)}

      before do
        allow(game_place).to receive(:get_position)
      end

      it 'sends place_marker to board_place' do
        expect(board_place).to receive(:place_marker)
        game_place.play('X')
      end
    end
  end

  describe '#get_position' do
    # Located inside #play (Public Script Method)
    # Looping Script -> Test the behavior of the method
    # e.g it stops when certain conditions are met

    context "when user's input position is between 1 and 9" do
      before do
        valid_input = '5'
        allow(player_game).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display error message' do
        player_x = player_game.instance_variable_get(:@player_x)
        error_message = 'Input Error! Please enter a position number between 1 and 9.'
        expect(player_game).not_to receive(:puts).with(error_message)
        player_game.get_position(player_x)
      end
    end

    context 'when user inputs incorrect value once, then a valid value' do
      before do
        valid_input = '7'
        invalid_input = '56'
        allow(player_game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'displays error message once, info message twice and then stops loop' do
        player_x = player_game.instance_variable_get(:@player_x)
        error_message = 'Input Error! Please enter a position number between 1 and 9.'
        info_message = "Player #{player_x} choose your position number (1-9)"
        expect(player_game).to receive(:puts).with(info_message).twice
        expect(player_game).to receive(:puts).with(error_message).once
        player_game.get_position(player_x)
      end
    end

    context 'when user inputs incorrect value twice, then a valid value' do
      before do
        letter = 'l'
        char = '#'
        valid_number = '1'
        allow(player_game).to receive(:gets).and_return(letter, char, valid_number)
      end

      it 'displays error message twice, info message 3 times and stops loop' do
        player_x = player_game.instance_variable_get(:@player_x)
        error_message = 'Input Error! Please enter a position number between 1 and 9.'
        info_message = "Player #{player_x} choose your position number (1-9)"
        expect(player_game).to receive(:puts).with(info_message).exactly(3).times
        expect(player_game).to receive(:puts).with(error_message).twice
        player_game.get_position(player_x)
      end
    end
  end
end
