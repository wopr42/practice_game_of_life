require 'spec_helper'

describe Board do
  context '.from_cucumber_table' do
    let(:table) do
      stub(:raw => [
        %w(. . x . .),
        %w(x . . x .),
      ])
    end

    let(:board) { Board.from_cucumber_table(table) }

    specify { board.should be_kind_of(Matrix) }
    specify { board.should be_kind_of(Board) }

    it 'converts x to 1' do
      board[0,2].should eq(1)
    end

    it 'converts . to 0' do
      board[0,0].should eq(0)
    end
  end

  context '.from_board' do
    let(:orig) { Board.rows [[1,1], [0,2]] }
    let(:dupe) { Board.from_board orig }

    it 'is equivalent to the original' do
      orig.should eq(dupe)
    end

    it 'is a different object' do
      orig.object_id.should_not eq(dupe.object_id)
    end
  end

  context '#center' do
    context 'of a 5x5 board' do
      let(:board) { Board.rows(Array.new(5) {Array.new(5, 0)}) }
      before { board[2,2] = 1 }
      specify { board.center.should eq(1) }
    end
  end
end
