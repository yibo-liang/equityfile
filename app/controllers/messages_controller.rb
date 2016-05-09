class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  def index
    @messages = Message.where("(messages.posted_by = ? AND messages.posted_to = ?) OR (messages.posted_by = ? AND messages.posted_to = ?)", params[:user_id], params[:friend_id], params[:friend_id], params[:user_id]).order("created_at ASC")

    #puts "\n\nMessages returned for user: \n\n"
    #@messages.each do |a|
      #puts a.to_json
    #end
    #puts @messages.to_json

    render json: @messages
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    render json: @message
  end

  # POST /messages/send
  # POST /messages/send.json
  def create
    @message = Message.new(message_params)

    if @message.posted_to != "" && @message.posted_by != "" && @message.content != "" && @message.posted_to != "null" 
      if @message.save
        #do nothing
      else
        render json: {error: "Error sending message..."}
      end
    else
      render json: {error: "Error sending message..."}
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      head :no_content
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy

    head :no_content
  end

  private

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.permit(:posted_by, :posted_to, :content)
    end
end
