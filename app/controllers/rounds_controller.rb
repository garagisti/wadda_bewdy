class RoundsController < SessionsController

  def index
    @rounds = Round.all
  end

  def show
    # This will show a nice view of the round
  end
end
