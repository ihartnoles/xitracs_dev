class NewhirecredentialsController < ApplicationController
  # GET /newhirecredentials
  # GET /newhirecredentials.json
  def index
    @newhirecredentials = Newhirecredential.all

    @qualificationreasons = Qualificationreason.all

    @newhirecredential = Newhirecredential.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @newhirecredentials }
    end
  end

  # GET /newhirecredentials/1
  # GET /newhirecredentials/1.json
  def show
    @newhirecredential = Newhirecredential.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @newhirecredential }
    end
  end

  # GET /newhirecredentials/new
  # GET /newhirecredentials/new.json
  def new
    @newhirecredential = Newhirecredential.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @newhirecredential }
    end
  end

  # GET /newhirecredentials/1/edit
  def edit
    @newhirecredential = Newhirecredential.find(params[:id])
  end

  # POST /newhirecredentials
  # POST /newhirecredentials.json
  def create
    @newhirecredential = Newhirecredential.new(params[:newhirecredential])

    respond_to do |format|
      if @newhirecredential.save
        format.html { redirect_to @newhirecredential, notice: 'Newhirecredential was successfully created.' }
        format.json { render json: @newhirecredential, status: :created, location: @newhirecredential }
      else
        format.html { render action: "new" }
        format.json { render json: @newhirecredential.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /newhirecredentials/1
  # PUT /newhirecredentials/1.json
  def update
    @newhirecredential = Newhirecredential.find(params[:id])

    respond_to do |format|
      if @newhirecredential.update_attributes(params[:newhirecredential])
        format.html { redirect_to @newhirecredential, notice: 'Newhirecredential was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @newhirecredential.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newhirecredentials/1
  # DELETE /newhirecredentials/1.json
  def destroy
    @newhirecredential = Newhirecredential.find(params[:id])
    @newhirecredential.destroy

    respond_to do |format|
      format.html { redirect_to newhirecredentials_url }
      format.json { head :ok }
    end
  end
end
