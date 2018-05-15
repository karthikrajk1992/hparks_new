class UserDetailsController < ApplicationController
skip_before_action :verify_authenticity_token
def new
	@plots = PlotSize.all
	@user_detail = UserDetail.new
	
	
end
def create
	
	@user_detail = UserDetail.new(user_detail_params)
	if @user_detail.save
		# binding.pry
		PaymentMailer.lead_registration(@user_detail).deliver_later
		PaymentMailer.lead_post(@user_detail).deliver_later
		redirect_to controller: 'payments', action: 'requestHandler', order_id: @user_detail[:id] 
 
	else
		# binding.pry
		render 'new'
	end
end
private
  def user_detail_params
    params.require(:user_detail).permit(:name, :email, :plot_details,:number,:payment_status,:description)
  end	

end