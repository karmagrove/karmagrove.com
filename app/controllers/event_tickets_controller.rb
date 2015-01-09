class EventTicketsController < ApplicationController

  def new
    # if user_signed_in?
      @event_ticket = EventTicket.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @member }
      end
    # else
      # redirect_to("/")
    # end
  end
end
