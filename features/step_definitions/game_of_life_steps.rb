Given /^the following setup$/ do |table|
  @board = table.raw.map do |row|
    row.map { |cell| '.' == cell ? 0 : 1 }
  end
  @center = [
    (@board.size / 2).floor,
    (@board.transpose.size / 2).floor,
  ]
end

When /^I evolve the board$/ do
  nextgen = Array.new(@board.size) { Array.new(@board.transpose.size, 0) }

  @board.each_with_index do |row, x|
    row.each_with_index do |col, y|
      count = 0

      [[x-1, y], [x-1, y+1], [x, y+1], [x+1, y+1], [x+1, y], [x+1, y-1], [x, y-1], [x-1, y-1]].each do |px, py|
        if px >= 0 and py >= 0 and px < @board.size and py < @board.transpose.size
          count += @board[px][py]
        end
      end

      nextgen[x][y] = 1 if 3 == count or (2 == count and 1 == @board[x][y])
    end
  end

  @board = nextgen
end

Then /^the center cell should be dead$/ do
  @board[@center[0]][@center[1]].should eq(0)
end

Then /^the center cell should be alive$/ do
  @board[@center[0]][@center[1]].should eq(1)
end

Then /^I should see the following board$/ do |table|
   @board == table.raw.map do |row|
     row.map { |cell| '.' == cell ? 0 : 1 }
   end
end
