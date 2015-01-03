class MembersController < ApplicationController
  def index
      @members = Member.all
      respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @member }
      end
  end


  # GET /products/1
  # GET /products/1.json
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    if user_signed_in?
      @member = Member.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @member }
      end
    else
      redirect_to("/")
    end
  end

  # GET /products/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @member = Product.new(params[:product])

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Product was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:product])
        format.html { redirect_to @member, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
