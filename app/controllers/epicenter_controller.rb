class EpicenterController < ApplicationController

	before_filter :authenticate_user!

  def feed

    @tweet = Tweet.new

  	@following_tweets = []

  	@tweets = Tweet.order(created_at: :desc)

  	@tweets.each do |t|
  		if current_user.following.include?(t.user_id) || current_user.id == t.user_id
  		@following_tweets.push(t)
  		end
  	end

    @follower_count = 0
    @users = User.all
    @users.each do |user|
      if user.following.include?(current_user.id)
        follower_count += 1
      end
    end

  end

  def show_user
  	@user = User.find(params[:id])
  end

  def now_following
  	user = User.find(params[:id])
  	current_user.following.push(user.id)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end

  def unfollow
  	user = User.find(params[:id])
  	current_user.following.delete(user.id)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end

  def all_users
    @users = User.all
  end

  def tag_index
    @tags = Tag.all
  end

  def all_followers
    @users = []
    User.all.each do |user|
      if user.following.include?(current_user.id)
        @users.push(user)
      end
    end 
  end

  def all_following
    @users = []
    current_user.following.each do |x|
      user = User.find(x)
      @users.push(user)
    end
  end 


  def jquery_practice 
  end 

end
