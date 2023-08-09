class TopicsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @topic = Topic.new
    render :new
  end 
  
  def create
    @topic = Topic.new(topic_params)
    
    if params[:topic][:image]
      @post.image.attach(params[:topic][:image])
    end
    
    if @topic.save
      redirect_to new_topic_path, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end 
  
  private
  def topic_params
    params.require(:topic).permit(:title, :body, :image)
  end
  
  def edit
    render :edit
  end 
  
  def update
    redirect_to 'topics/edit'
  end 
end