class CirclesController < ApplicationController


  def index
    #@donations = Donation.all
     respond_to do |format|
      format.html
      format.svg  { render :qrcode => request.url.gsub('.svg','.html'), :unit => 10 }
    end

  end
end
