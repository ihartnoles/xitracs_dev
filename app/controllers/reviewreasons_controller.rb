class ReviewreasonsController < ApplicationController
  # GET /reviewreasons
  # GET /reviewreasons.json
  def index
    @reviewreasons = Reviewreason.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviewreasons }
    end
  end

  # GET /reviewreasons/1
  # GET /reviewreasons/1.json
  def show
    @reviewreason = Reviewreason.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reviewreason }
    end
  end

  # GET /reviewreasons/new
  # GET /reviewreasons/new.json
  def new
    @reviewreason = Reviewreason.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reviewreason }
    end
  end

  # GET /reviewreasons/1/edit
  def edit
    @reviewreason = Reviewreason.find(params[:id])
  end

  # POST /reviewreasons
  # POST /reviewreasons.json
  def create
    @reviewreason = Reviewreason.new(params[:reviewreason])

    respond_to do |format|
      if @reviewreason.save
        format.html { redirect_to @reviewreason, notice: 'Reviewreason was successfully created.' }
        format.json { render json: @reviewreason, status: :created, location: @reviewreason }
      else
        format.html { render action: "new" }
        format.json { render json: @reviewreason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviewreasons/1
  # PUT /reviewreasons/1.json
  def update
    @reviewreason = Reviewreason.find(params[:id])

    respond_to do |format|
      if @reviewreason.update_attributes(params[:reviewreason])
        format.html { redirect_to @reviewreason, notice: 'Reviewreason was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reviewreason.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviewreasons/1
  # DELETE /reviewreasons/1.json
  def destroy
    @reviewreason = Reviewreason.find(params[:id])
    @reviewreason.destroy

    respond_to do |format|
      format.html { redirect_to reviewreasons_url }
      format.json { head :ok }
    end
  end
end
