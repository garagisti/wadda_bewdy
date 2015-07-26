class RoundsController < SessionsController

  # SDP: I presume you need to pass the season year at some point? How will you do it
  # as part of the path or the querystring? Requires thought at this early stage
  def index
    @rounds = Round.all
  end

  def show
    # This will show a nice view of the round
  end
end
