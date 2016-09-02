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
      render :confirmation
    else
      flash[:danger] = "Something has gone wrong"
      render :new
    end
  end

  def update
    @applicant.update_attributes(applicant_params)

    render :thanks
  end

  def show
    # your code here
  end

  private

  def set_applicant
    @applicant = Applicant.find params[:id]
  end

  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone,
                                      :phone_type, :region, :confirm_background_check)
  end
end
