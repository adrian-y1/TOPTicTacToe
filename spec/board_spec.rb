require './lib/board'

describe Board do
  subject(:board) { described_class.new('X', 'O') }
  describe '#winner?' do
    context "when the board is new and doesn't have markers" do
      it 'returns false' do
        expect(board).to_not be_winner
      end
    end

    context 'when the board has some markers but not 3 consecutively' do
      it 'returns false' do
        board.board = ['X', 2, 'O', 'X', 5, 6, 7, 'O', 9]
        expect(board).to_not be_winner
      end
    end

    context 'When a player has 3 consecutive markers vertically' do
      it 'returns true' do
        board.board = ['X', 2, 'O', 'X', 'O', 6, 'X', 8, 9]
        expect(board).to be_winner
      end
    end

    context 'when a player has 3 consecutive markers horizontally' do
      it 'returns true' do
        board.board = ['X', 'X', 'X', 'O', 5, 6, 7, 'O', 9]
        expect(board).to be_winner
      end
    end

    context 'when a player has 3 consecutive markers diagonally' do
      it 'returns true' do
        board.board = ['X', 2, 3, 4, 'X', 6, 7, 8, 'X']
        expect(board).to be_winner
      end
    end
  end

  describe '#full?' do
    context 'When the board is new and has no markers' do
      it 'returns false' do
        expect(board).to_not be_full
      end
    end

    context 'When the board has some markers' do
      it 'returns false' do
        board.board = ['X', 'O', 3, 4, 'O', 6, 7, 8, 'X']
        expect(board).to_not be_full
      end
    end

    context 'When every square is a marker and not a position number' do
      it 'returns true' do
        board.board = ['X', 'X', 'O', 'O', 'X', 'X', 'X', 'O', 'O']
        expect(board).to be_full
      end
    end
  end

  describe '#free?' do
    context 'when the given position is an integer' do
      it 'returns true' do
        position = 5
        expect(board.free?(position)).to eq(true)
      end
    end

    context 'when the given position is not an integer' do
      it 'returns false' do
        board.board = ['X', 2, 3, 4, 5, 6, 7, 8, 9]
        position = 1
        expect(board.free?(position)).to eq(false)
      end
    end
  end

  describe '#place_marker' do
    context 'when given player_x and position index of [1, 1]' do
      it "sets player_x's marker at position 5" do
        position = 3
        expect { board.place_marker('X', position) }.to change { board.board[2] }.from(3).to('X')
      end
    end
  end
end
