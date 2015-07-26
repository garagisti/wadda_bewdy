class RoundsController < SessionsController

  # SDP: I presume you need to pass the season year at some point? How will you do it
  # as part of the path or the querystring? Requires thought at this early stage
  def index
    @rounds = Round.all
  end

  def show
    begin
      @rounds = Round.find(params[:id])
      @circuit = Circuit.find_by_id(@rounds.circuit_id)
    rescue
      redirect_to rounds_path
    end
  end
end
