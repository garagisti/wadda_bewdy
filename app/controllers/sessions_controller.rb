class SessionsController < ApplicationController
  # SDP: Probably can remove the only: hash key
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
