class NewhirecredentialsController < ApplicationController
  # GET /newhirecredentials
  # GET /newhirecredentials.json
  def index
    @newhire = Newhire.find(session[:newhire_id])
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
    #@newhire = Newhire.find(session[:newhire_id])
    @qualificationreasons = Qualificationreason.all
    @newhirecredential = Newhirecredential.new

    @newhire = Newhire.find(params[:newhire_id])
    @newhirecourse = Newhirecourse.new
    @newhire_dept = Department.find(@newhire.department_id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @newhirecredential }
    end
  end

  # GET /newhirecredentials/1/edit
  def edit
    @newhire = Newhire.find(params[:newhire_id])
    @qualificationreasons = Qualificationreason.all
    @newhirecredential = Newhirecredential.find(params[:id])
  end

  # POST /newhirecredentials
  # POST /newhirecredentials.json
  def create
    if ( params[:qualificationreason_id].blank? || params[:qualification_explanation].blank?) 
          flash[:notice] = 'Please fill out all fields'
          redirect_to newhirecredentials_path
    else 
          @newhirecredential = Newhirecredential.new(:qualificationreason_id => params[:qualificationreason_id], 
                                                     :qualification_explanation => params[:qualification_explanation], 
                                                     :newhire_id => params[:newhire_id],
                                                     :course_id => params[:course_id])
          #@newhirecredential.save

          if @newhirecredential.save
            
            # Force Relevant Coursework entries if (a) for all options except: “Terminal degree in teaching discipline” & “Other terminal degree – credential by research/experience/creative activity
            if ( params[:qualificationreason_id] == "1" || params[:qualificationreason_id] == "2")
              
              #go to comments
              redirect_to newhirecomment_index_path(:newhire_id => params[:newhire_id], :course_id => params[:course_id])
            else
              #go to credits (relevant coursework)            
              redirect_to newhirecredits_path(:newhire_id => params[:newhire_id], :course_id => params[:course_id])
            end
           
          else
             flash[:notice] = "A problem occurred saving the credential."
         
          end
      end
  end

  # PUT /newhirecredentials/1
  # PUT /newhirecredentials/1.json
  def update
    @newhirecredential = Newhirecredential.find(params[:id])

    #@newhirecredential.qualificationreason_id =
    
      if @newhirecredential.update_attributes(params[:newhirecredential])
         flash[:notice] = "Credential successfully updated."
      else
        flash[:notice] = "There was a problem updating the credential."
      end
    
      redirect_to newhiredetails_path(params[:newhire_id])
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
