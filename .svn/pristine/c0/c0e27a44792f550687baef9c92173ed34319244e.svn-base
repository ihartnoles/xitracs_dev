class KeyvaluesController < ApplicationController
  # GET /keyvalues
  # GET /keyvalues.json
  def index
    @keyvalues = Keyvalue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keyvalues }
    end
  end

  # GET /keyvalues/1
  # GET /keyvalues/1.json
  def show
    @keyvalue = Keyvalue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @keyvalue }
    end
  end

  # GET /keyvalues/new
  # GET /keyvalues/new.json
  def new
    @keyvalue = Keyvalue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyvalue }
    end
  end

  # GET /keyvalues/1/edit
  def edit
    @keyvalue = Keyvalue.find(params[:id])
  end

  # POST /keyvalues
  # POST /keyvalues.json
  def create
    @keyvalue = Keyvalue.new(params[:keyvalue])

    respond_to do |format|
      if @keyvalue.save
        format.html { redirect_to @keyvalue, notice: 'Keyvalue was successfully created.' }
        format.json { render json: @keyvalue, status: :created, location: @keyvalue }
      else
        format.html { render action: "new" }
        format.json { render json: @keyvalue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /keyvalues/1
  # PUT /keyvalues/1.json
  def update
    @keyvalue = Keyvalue.find(params[:id])

    respond_to do |format|
      if @keyvalue.update_attributes(params[:keyvalue])
        format.html { redirect_to @keyvalue, notice: 'Keyvalue was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @keyvalue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keyvalues/1
  # DELETE /keyvalues/1.json
  def destroy
    @keyvalue = Keyvalue.find(params[:id])
    @keyvalue.destroy

    respond_to do |format|
      format.html { redirect_to keyvalues_url }
      format.json { head :ok }
    end
  end
end
