require File.expand_path('../../test_helper', __FILE__)

describe "On the", GemsController, "a visitor" do
  it "sees a page with all recommended gems" do
    get :index
    status.should.be :ok
    assert_select 'div'
    assigns(:rocks).should.not.be.empty
  end
end