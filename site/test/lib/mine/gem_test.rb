require File.expand_path('../../../test_helper', __FILE__)

describe Mine::Gem do
  it "computes a score based on the number of downloads" do
    [
      [{'downloads' => 0, 'version_downloads' => 0}, Mine::Gem::DISQUALIFIED],
      [{'downloads' => 100, 'version_downloads' => 20},  0.2],
      [{'downloads' => Mine::Gem::USED_TOO_MUCH + 1, 'version_downloads' => 100}, Mine::Gem::DISQUALIFIED]
    ].each do |attributes, expected|
      Mine::Gem.new(attributes).score.should == expected
    end
  end
end