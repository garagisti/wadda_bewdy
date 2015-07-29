class LeaguesController < ApplicationController

def index
  @users = User.all
end

end
