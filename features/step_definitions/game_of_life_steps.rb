Given /^the following setup$/ do |table|
  @board = Board.from_cucumber_table(table)
end

When /^I evolve the board$/ do
  @board.evolve!
end

Then /^the center cell should be dead$/ do
  @board.center.should eq(0)
end

Then /^the center cell should be alive$/ do
  @board.center.should eq(1)
end

Then /^I should see the following board$/ do |table|
   @board == Board.from_cucumber_table(table)
end
