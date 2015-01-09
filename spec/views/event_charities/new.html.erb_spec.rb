require 'spec_helper'

describe "event_charities/new" do
  before(:each) do
    assign(:event_charity, stub_model(EventCharity).as_new_record)
  end

  it "renders new event_charity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_charities_path, "post" do
    end
  end
end
