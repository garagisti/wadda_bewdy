class RoundsController < SessionsController

  def index
    @rounds = Round.all
  end

  def show
  end
end
