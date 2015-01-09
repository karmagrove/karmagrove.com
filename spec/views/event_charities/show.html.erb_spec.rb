require 'spec_helper'

describe "event_charities/show" do
  before(:each) do
    @event_charity = assign(:event_charity, stub_model(EventCharity))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
