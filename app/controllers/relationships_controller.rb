class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:id])

    if current_user.following? @user
      redirect_to user_path(@user), alert: "Usuário já está sendo seguido"
    else
      current_user.follow @user
      redirect_to user_path(@user), alert: "Usuário seguindo com sucesso"
    end
  end

  def destroy
    @user = User.find(params[:id])

    if current_user.following? @user
      current_user.unfollow @user
      redirect_to user_path(@user), alert: "Usuário não seguido mais"
    else
      redirect_to user_path(@user), alert: "Ocorreu um erro"
    end
  end
end
