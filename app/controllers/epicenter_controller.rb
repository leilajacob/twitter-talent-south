class EpicenterController < ApplicationController

	before_filter :authenticate_user!

  def feed

  	@following_tweets = []

  	@tweets = Tweet.order(created_at: :desc)

  	@tweets.each do |t|
  		if current_user.following.include?(t.user_id)
  		@following_tweets.push(t)
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
end
