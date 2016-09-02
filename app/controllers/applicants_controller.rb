class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new applicant_params
    @applicant.workflow_state = "applied"
    if @applicant.save

      render :confirmation
    else
      render :new
    end
  end

  def update
    # your code here
  end

  def show
    # your code here
  end

  private

  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone, :phone_type, :region)
  end
end
