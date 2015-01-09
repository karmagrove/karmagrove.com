require 'spec_helper'

describe "event_charities/index" do
  before(:each) do
    assign(:event_charities, [
      stub_model(EventCharity),
      stub_model(EventCharity)
    ])
  end

  it "renders a list of event_charities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
