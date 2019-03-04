class ConfirmsController < ApplicationController

  def index
    @confirms = Confirm.all
    render json: @confirms
  end

  def create
    @confirm = Confirm.create(confirm_params)
    @event = @confirm.event
    render json: {confirm: @confirm, event: @event}
  end

  def update
    params["attended_id"].each{ |id|
      confirm = Confirm.find(id)
      event = Event.find(confirm.event_id)
      user = User.find(confirm.user_id)

      if confirm.attend == false && event.donations.count > 1
        donations = event.donations
        total_donations = donations.map{ |d| d.amount_per_volunteer}.reduce(:+)
        user.update(credit: user.credit + total_donations)
        donations.each{ |d|
          sponsor = Sponsor.find(d.sponsor_id)
          sponsor.update(
            credit: sponsor.credit - d.amount_per_volunteer,
            total_donations: sponsor.total_donations + d.amount_per_volunteer)
        }
      end
      confirm.update(attend: true)
    }
    render json: {attended_id: params["attended_id"]}
  end

  def destroy
    @confirm = Confirm.find(params[:id])
    @confirm_id = @confirm.id
    @confirm.destroy
    render json: {destroyed_confirm_id: @confirm.id}
  end

  private
  def confirm_params
    params.require(:confirm).permit(:user_id, :event_id)
  end
end
