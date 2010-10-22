require File.expand_path('../../test_helper', __FILE__)

describe Mine do
  it "raises an exception when something goes wrong while fetching gems" do
    REST.expects(:get).returns(REST::Response.new(500))
    lambda {
      Mine.fetch(12)
    }.should.raise(RuntimeError)
  end
end

describe Mine, "when receiving a JSON description of gems" do
  before do
    @response = REST::Response.new(200, {}, File.read(File.expand_path('../../fixtures/files/gems.json', __FILE__)))
  end
  
  it "fetches all gems from a page" do
    REST.stubs(:get).with("http://rubygems.org/api/v1/search.json?query=&page=1").returns(@response)
    description = Mine.fetch(1)
    description.length.should == 30
    description[0]['name'].should == 'cucumber'
  end
  
  it "returns all gems from a page" do
    REST.stubs(:get).with("http://rubygems.org/api/v1/search.json?query=&page=2").returns(@response)
    gems = Mine.all(2)
    gems.length.should == 30
    gems.first.name.should == 'cucumber'
    gems.first.downloads.should == 293316
  end
end