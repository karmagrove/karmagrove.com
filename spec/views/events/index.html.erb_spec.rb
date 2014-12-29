require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :name => "Name",
        :description => "MyText",
        :price => 1,
        :image_url => "Image Url",
        :seller => nil,
        :address => "Address",
        :city => "City",
        :state => "State",
        :zip_code => 2
      ),
      stub_model(Event,
        :name => "Name",
        :description => "MyText",
        :price => 1,
        :image_url => "Image Url",
        :seller => nil,
        :address => "Address",
        :city => "City",
        :state => "State",
        :zip_code => 2
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
