class TipController < SessionsController

  def index
    @rounds = Round.all
    @user = User.find_by_id(current_user.id)
  end

  # GET /tips/new
  def new
    @tip = Tip.new
    @round = Round.find_by_id(params[:round_id])
    @circuit = Circuit.find_by_id(@round.circuit_id)
    @drivers = Driver.all
  end

  # POST /tips
  def create
    @tip = current_user.tips.build(white_listed_parameters)
    @tip.round_id = params[:round_id]
    if @tip.save
      flash[:notice] = 'Tip saved successfully'
      redirect_to rounds_path
    else
      flash[:alert] = 'Error Saving Your Tips'
      render :new
    end
  end

  # GET /tips/:id/edit
  # Edit a tip if a user has made tips but before the round cut-off over
  def edit
    @tip = Tip.where("user_id = ? AND round_id = ?",current_user.id,params[:id]).first
    @drivers = Driver.all
  end


  # GET /tip/:id
  def show
    # get the tips relevant to the round.
    @tip = Tip.where("user_id = ? AND round_id = ?",current_user.id,params[:id]).first
    if !@tip.nil?
        @round = Round.find_by_id(params[:id])
        @qly_tips = get_qly_tips(@tip)
        @race_tips = get_race_tips(@tip)
      else
        flash[:alert] = 'Error No tips for this round'
        redirect_to rounds_path
      end
  end

  private

  def get_qly_tips(tip)
    qly_tips = {}
    qly_tips[:pole] = Driver.find_by_id(tip.qly_tip_1)
    qly_tips[:second] = Driver.find_by_id(tip.qly_tip_2)
    qly_tips[:third] = Driver.find_by_id(tip.qly_tip_3)
    return qly_tips
  end

  def get_race_tips(tip)
    race_tips = {}
    race_tips[:winner] = Driver.find_by_id(tip.race_tip_1)
    race_tips[:second] = Driver.find_by_id(tip.race_tip_2)
    race_tips[:third] = Driver.find_by_id(tip.race_tip_3)
    race_tips[:fourth] = Driver.find_by_id(tip.race_tip_4)
    race_tips[:fifth] = Driver.find_by_id(tip.race_tip_5)
    race_tips[:sixth] = Driver.find_by_id(tip.race_tip_6)
    race_tips[:seventh] = Driver.find_by_id(tip.race_tip_7)
    race_tips[:eighth] = Driver.find_by_id(tip.race_tip_8)
    race_tips[:ninth] = Driver.find_by_id(tip.race_tip_9)
    race_tips[:tenth] = Driver.find_by_id(tip.race_tip_10)
    return race_tips
  end

  def white_listed_parameters
    params
    .require(:tip)
    .permit(:round_id, :qly_tip_1, :qly_tip_2, :qly_tip_3,
            :race_tip_1, :race_tip_2, :race_tip_3, :race_tip_4,
            :race_tip_5, :race_tip_6, :race_tip_7, :race_tip_8,
            :race_tip_9, :race_tip_10)
  end
end
