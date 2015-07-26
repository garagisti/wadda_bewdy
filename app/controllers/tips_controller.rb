class TipsController < SessionsController

  def index
    if params.has_key?(:round_id)
      @round = Round.find(params[:round_id])
      @tip = @round.tip
    else
      @tip = Tip.new
    end
  end

  # GET /tips/new
  def new
    @tip = Tip.new
  end

  # POST /tips
  def create
    @tip = Tip.new(white_listed_parameters)
    @tip.user_id = current_user.id
    @tip.round_id = round_id
    if @tip.save
      flash[:notice] = 'Tip saved successfully'
      redirect_to rounds_path
    else
      flash[:alert] = 'Error Saving Your Tips'
      render :new
    end
  end

  # GET /tips/:id/edit
  def edit
  end

  private

  def white_listed_parameters
    params
    .require(:tip)
    .permit(:user_id, :round_id, :qly_tip_1, :qly_tip_2, :qly_tip_3,
            :race_tip_1, :race_tip_2, :race_tip_3, :race_tip_4,
            :race_tip_5, :race_tip_6, :race_tip_7, :race_tip_8,
            :race_tip_9, :race_tip_10)
  end
end
