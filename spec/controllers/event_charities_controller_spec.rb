require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe EventCharitiesController do

  # This should return the minimal set of attributes required to create a valid
  # EventCharity. As you add validations to EventCharity, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EventCharitiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all event_charities as @event_charities" do
      event_charity = EventCharity.create! valid_attributes
      get :index, {}, valid_session
      assigns(:event_charities).should eq([event_charity])
    end
  end

  describe "GET show" do
    it "assigns the requested event_charity as @event_charity" do
      event_charity = EventCharity.create! valid_attributes
      get :show, {:id => event_charity.to_param}, valid_session
      assigns(:event_charity).should eq(event_charity)
    end
  end

  describe "GET new" do
    it "assigns a new event_charity as @event_charity" do
      get :new, {}, valid_session
      assigns(:event_charity).should be_a_new(EventCharity)
    end
  end

  describe "GET edit" do
    it "assigns the requested event_charity as @event_charity" do
      event_charity = EventCharity.create! valid_attributes
      get :edit, {:id => event_charity.to_param}, valid_session
      assigns(:event_charity).should eq(event_charity)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new EventCharity" do
        expect {
          post :create, {:event_charity => valid_attributes}, valid_session
        }.to change(EventCharity, :count).by(1)
      end

      it "assigns a newly created event_charity as @event_charity" do
        post :create, {:event_charity => valid_attributes}, valid_session
        assigns(:event_charity).should be_a(EventCharity)
        assigns(:event_charity).should be_persisted
      end

      it "redirects to the created event_charity" do
        post :create, {:event_charity => valid_attributes}, valid_session
        response.should redirect_to(EventCharity.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event_charity as @event_charity" do
        # Trigger the behavior that occurs when invalid params are submitted
        EventCharity.any_instance.stub(:save).and_return(false)
        post :create, {:event_charity => {  }}, valid_session
        assigns(:event_charity).should be_a_new(EventCharity)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        EventCharity.any_instance.stub(:save).and_return(false)
        post :create, {:event_charity => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested event_charity" do
        event_charity = EventCharity.create! valid_attributes
        # Assuming there are no other event_charities in the database, this
        # specifies that the EventCharity created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        EventCharity.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => event_charity.to_param, :event_charity => { "these" => "params" }}, valid_session
      end

      it "assigns the requested event_charity as @event_charity" do
        event_charity = EventCharity.create! valid_attributes
        put :update, {:id => event_charity.to_param, :event_charity => valid_attributes}, valid_session
        assigns(:event_charity).should eq(event_charity)
      end

      it "redirects to the event_charity" do
        event_charity = EventCharity.create! valid_attributes
        put :update, {:id => event_charity.to_param, :event_charity => valid_attributes}, valid_session
        response.should redirect_to(event_charity)
      end
    end

    describe "with invalid params" do
      it "assigns the event_charity as @event_charity" do
        event_charity = EventCharity.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        EventCharity.any_instance.stub(:save).and_return(false)
        put :update, {:id => event_charity.to_param, :event_charity => {  }}, valid_session
        assigns(:event_charity).should eq(event_charity)
      end

      it "re-renders the 'edit' template" do
        event_charity = EventCharity.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        EventCharity.any_instance.stub(:save).and_return(false)
        put :update, {:id => event_charity.to_param, :event_charity => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested event_charity" do
      event_charity = EventCharity.create! valid_attributes
      expect {
        delete :destroy, {:id => event_charity.to_param}, valid_session
      }.to change(EventCharity, :count).by(-1)
    end

    it "redirects to the event_charities list" do
      event_charity = EventCharity.create! valid_attributes
      delete :destroy, {:id => event_charity.to_param}, valid_session
      response.should redirect_to(event_charities_url)
    end
  end

end