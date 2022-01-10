# frozen_string_literal: true

class UserController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
  end
end
