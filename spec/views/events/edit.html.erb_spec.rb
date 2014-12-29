require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :name => "MyString",
      :description => "MyText",
      :price => 1,
      :image_url => "MyString",
      :seller => nil,
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip_code => 1
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_path(@event), "post" do
      assert_select "input#event_name[name=?]", "event[name]"
      assert_select "textarea#event_description[name=?]", "event[description]"
      assert_select "input#event_price[name=?]", "event[price]"
      assert_select "input#event_image_url[name=?]", "event[image_url]"
      assert_select "input#event_seller[name=?]", "event[seller]"
      assert_select "input#event_address[name=?]", "event[address]"
      assert_select "input#event_city[name=?]", "event[city]"
      assert_select "input#event_state[name=?]", "event[state]"
      assert_select "input#event_zip_code[name=?]", "event[zip_code]"
    end
  end
end
