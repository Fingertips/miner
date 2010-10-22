require File.expand_path('../../test_helper', __FILE__)

describe Mine do
  it "raises an exception when something goes wrong while fetching gems" do
    REST.expects(:get).returns(REST::Response.new(500))
    lambda {
      Mine.fetch
    }.should.raise(RuntimeError)
  end
end

describe Mine, "when receiving a JSON description of gems" do
  before do
    REST.stubs(:get).returns(
      REST::Response.new(200, {}, File.read(File.expand_path('../../fixtures/files/gems.json', __FILE__)))
    )
  end
  
  it "fetches all gems" do
    description = Mine.fetch
    description.length.should == 30
    description[0]['name'].should == 'cucumber'
  end
  
  it "returns all gems" do
    gems = Mine.all
    gems.length.should == 30
    gems.first.name.should == 'cucumber'
    gems.first.downloads.should == 293316
  end
end