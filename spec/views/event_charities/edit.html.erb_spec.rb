require 'spec_helper'

describe "event_charities/edit" do
  before(:each) do
    @event_charity = assign(:event_charity, stub_model(EventCharity))
  end

  it "renders the edit event_charity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_charity_path(@event_charity), "post" do
    end
  end
end
