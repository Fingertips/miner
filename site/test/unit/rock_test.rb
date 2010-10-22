require File.expand_path('../../test_helper', __FILE__)

describe Rock do
  it "returns the hottest ones" do
    Rock.hottest.should.equal_list rocks(:nap, :i18n, :builder, :active_support)
  end
end