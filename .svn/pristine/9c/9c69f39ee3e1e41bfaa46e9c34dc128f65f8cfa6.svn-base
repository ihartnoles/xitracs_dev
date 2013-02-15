class DonesemestersController < ApplicationController
  # GET /donesemesters
  # GET /donesemesters.json
  def index
    @donesemesters = Donesemester.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @donesemesters }
    end
  end

  # GET /donesemesters/1
  # GET /donesemesters/1.json
  def show
    @donesemester = Donesemester.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donesemester }
    end
  end

  # GET /donesemesters/new
  # GET /donesemesters/new.json
  def new
    @donesemester = Donesemester.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @donesemester }
    end
  end

  # GET /donesemesters/1/edit
  def edit
    @donesemester = Donesemester.find(params[:id])
  end

  # POST /donesemesters
  # POST /donesemesters.json
  def create
    @donesemester = Donesemester.new(params[:donesemester])

    respond_to do |format|
      if @donesemester.save
        format.html { redirect_to @donesemester, notice: 'Donesemester was successfully created.' }
        format.json { render json: @donesemester, status: :created, location: @donesemester }
      else
        format.html { render action: "new" }
        format.json { render json: @donesemester.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /donesemesters/1
  # PUT /donesemesters/1.json
  def update
    @donesemester = Donesemester.find(params[:id])

    respond_to do |format|
      if @donesemester.update_attributes(params[:donesemester])
        format.html { redirect_to @donesemester, notice: 'Donesemester was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @donesemester.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donesemesters/1
  # DELETE /donesemesters/1.json
  def destroy
    @donesemester = Donesemester.find(params[:id])
    @donesemester.destroy

    respond_to do |format|
      format.html { redirect_to donesemesters_url }
      format.json { head :ok }
    end
  end
end
