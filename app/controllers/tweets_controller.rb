class TweetsController < ApplicationController
  def create
    @tweet = current_user.tweets.new(tweet_params)

    if @tweet.save
      redirect_to root_path, notice: "Tweet salvo"
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
