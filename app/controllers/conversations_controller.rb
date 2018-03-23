class ConversationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def show
    @conversation = Conversation.find(params[:id])
    redirect_to request.referrer || root_url if @conversation.nil?
  end

  def create
    conversation = Conversation.new(newbie_id: current_user.id, expert_id: params[:applier_id],
                                    request_id: params[:request_id])
    if conversation.save
      redirect_to conversation
    else
      flash[:danger] = conversation.errors.messages[:base][0]
      redirect_to request.referrer || root_url
    end
  end
end
