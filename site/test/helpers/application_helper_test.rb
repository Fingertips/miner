require File.expand_path('../../test_helper', __FILE__)

describe ApplicationHelper do
  it "formats authors" do
    [
      [[], 'No authors specified'],
      [['Manfred'], 'Manfred'],
      [['Eloy', 'Manfred'], 'Eloy and Manfred']
    ].each do |example, expected|
      format_authors(example).should == expected
    end
  end
end