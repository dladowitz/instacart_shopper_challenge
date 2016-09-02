class AddConfirmBackgroundCheckToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :confirm_background_check, :boolean
  end
end
