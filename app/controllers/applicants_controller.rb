class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:edit, :update]

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new applicant_params
    @applicant.workflow_state = "applied"

    if @applicant.save
      flash[:success] = "Application created successfully"
      session[:applicant_id] = @applicant.id
      render :confirmation
    else
      flash[:danger] = "Something has gone wrong"
      render :new
    end
  end

  def update
    if @applicant.update_attributes(applicant_params)
      render :thanks
    else
      render :edit
    end
  end

  private

  def set_applicant
    @applicant = Applicant.find session[:applicant_id]

    render :new unless @applicant
  end

  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone,
                                      :phone_type, :region, :confirm_background_check)
  end
end
