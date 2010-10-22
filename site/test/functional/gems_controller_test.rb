require File.expand_path('../../test_helper', __FILE__)

describe "On the", GemsController, "a visitor" do
  before do
    Mine.stubs(:fetch).returns(JSON.parse(File.read(File.expand_path('../../fixtures/files/gems.json', __FILE__))))
  end
  
  it "sees a page with all recommended gems" do
    get :index
    status.should.be :ok
    assert_select 'div'
  end
end