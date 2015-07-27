class Round < ActiveRecord::Base
  belongs_to :circuit
  has_one :qly_result
  has_one :race_result
  has_one :tip

  validates_presence_of :round_number, :circuit_id, :qly_datetime, :race_datetime

  attr_reader :round_id

  # Is the current round on?
  def is_current?
    race_datetime > (DateTime.current - 1.hour) &&
    !(race_datetime > (DateTime.current + 5.weeks))
  end

  def calulate_points(user)
    # user = User.find_by_id(user_id)
    user_tip = Tip.where("user_id = ? AND round_id = ?",user.id,id).first
    qly_result = QlyResult.find_by_round_id(id)
    race_result = RaceResult.find_by_round_id(id)

    points = 0

    if (!user_tip.nil? && !qly_result.nil?)
      calulate_qly_points(user_tip, qly_result, points)
    end

    if (!user_tip.nil? && !race_result.nil?)
      calulate_race_points(user_tip, race_result, points)
    end

  end

  private

  def calulate_qly_points(user_tip, qly_result, points)
    # Points for Pole
    if user_tip.qly_tip_1 == qly_result.qly_result_1
      points += 10
    elsif user_tip.qly_tip_1 == qly_result.qly_result_2
      points += 8
    elsif user_tip.qly_tip_1 == qly_result.qly_result_3
      points += 6
    end

    # Points for 2nd on grid
    if user_tip.qly_tip_2 == qly_result.qly_result_1
      points += 8
    elsif user_tip.qly_tip_2 == qly_result.qly_result_2
      points += 10
    elsif user_tip.qly_tip_2 == qly_result.qly_result_3
      points += 8
    end

    # Points for 3rd on grid
    if user_tip.qly_tip_3 == qly_result.qly_result_1
      points += 6
    elsif user_tip.qly_tip_3 == qly_result.qly_result_2
      points += 8
    elsif user_tip.qly_tip_3 == qly_result.qly_result_3
      points += 10
    end

    return points
  end

  def calulate_race_points(user_tip, race_result, points)
    # Points for Winner

    if user_tip.race_tip_1 == race_result.race_result_1
      points += 15
    elsif user_tip.race_tip_1 == race_result.race_result_2
      points += 12
    elsif user_tip.race_tip_1 == race_result.race_result_3
      points += 10
    elsif user_tip.race_tip_1 == race_result.race_result_4
      points += 8
    elsif user_tip.race_tip_1 == race_result.race_result_5
      points += 6
    elsif user_tip.race_tip_1 == race_result.race_result_6
      points += 5
    elsif user_tip.race_tip_1 == race_result.race_result_7
      points += 4
    elsif user_tip.race_tip_1 == race_result.race_result_8
      points += 3
    elsif user_tip.race_tip_1 == race_result.race_result_9
      points += 2
    elsif user_tip.race_tip_1 == race_result.race_result_10
      points += 1
    end

    # Points for 2nd in race
    if user_tip.race_tip_2 == race_result.race_result_1
      points += 12
    elsif user_tip.race_tip_2 == race_result.race_result_2
      points += 15
    elsif user_tip.race_tip_2 == race_result.race_result_3
      points += 12
    elsif user_tip.race_tip_2 == race_result.race_result_4
      points += 10
    elsif user_tip.race_tip_2 == race_result.race_result_5
      points += 8
    elsif user_tip.race_tip_2 == race_result.race_result_6
      points += 6
    elsif user_tip.race_tip_2 == race_result.race_result_7
      points += 5
    elsif user_tip.race_tip_2 == race_result.race_result_8
      points += 4
    elsif user_tip.race_tip_2 == race_result.race_result_9
      points += 3
    elsif user_tip.race_tip_2 == race_result.race_result_10
      points += 2
    end

    # Points for 3rd in race
    if user_tip.race_tip_3 == race_result.race_result_1
      points += 10
    elsif user_tip.race_tip_3 == race_result.race_result_2
      points += 12
    elsif user_tip.race_tip_3 == race_result.race_result_3
      points += 15
    elsif user_tip.race_tip_3 == race_result.race_result_4
      points += 12
    elsif user_tip.race_tip_3 == race_result.race_result_5
      points += 10
    elsif user_tip.race_tip_3 == race_result.race_result_6
      points += 8
    elsif user_tip.race_tip_3 == race_result.race_result_7
      points += 6
    elsif user_tip.race_tip_3 == race_result.race_result_8
      points += 5
    elsif user_tip.race_tip_3 == race_result.race_result_9
      points += 4
    elsif user_tip.race_tip_3 == race_result.race_result_10
      points += 3
    end

        # Points for 4th in race
    if user_tip.race_tip_4 == race_result.race_result_1
      points += 8
    elsif user_tip.race_tip_4 == race_result.race_result_2
      points += 10
    elsif user_tip.race_tip_4 == race_result.race_result_3
      points += 12
    elsif user_tip.race_tip_4 == race_result.race_result_4
      points += 15
    elsif user_tip.race_tip_4 == race_result.race_result_5
      points += 12
    elsif user_tip.race_tip_4 == race_result.race_result_6
      points += 10
    elsif user_tip.race_tip_4 == race_result.race_result_7
      points += 8
    elsif user_tip.race_tip_4 == race_result.race_result_8
      points += 6
    elsif user_tip.race_tip_4 == race_result.race_result_9
      points += 5
    elsif user_tip.race_tip_4 == race_result.race_result_10
      points += 4
    end

        # Points for 5th in race
    if user_tip.race_tip_5 == race_result.race_result_1
      points += 6
    elsif user_tip.race_tip_5 == race_result.race_result_2
      points += 8
    elsif user_tip.race_tip_5 == race_result.race_result_3
      points += 10
    elsif user_tip.race_tip_5 == race_result.race_result_4
      points += 12
    elsif user_tip.race_tip_5 == race_result.race_result_5
      points += 15
    elsif user_tip.race_tip_5 == race_result.race_result_6
      points += 12
    elsif user_tip.race_tip_5 == race_result.race_result_7
      points += 10
    elsif user_tip.race_tip_5 == race_result.race_result_8
      points += 8
    elsif user_tip.race_tip_5 == race_result.race_result_9
      points += 6
    elsif user_tip.race_tip_5 == race_result.race_result_10
      points += 5
    end

        # Points for 6th in race
    if user_tip.race_tip_6 == race_result.race_result_1
      points += 5
    elsif user_tip.race_tip_6 == race_result.race_result_2
      points += 6
    elsif user_tip.race_tip_6 == race_result.race_result_3
      points += 8
    elsif user_tip.race_tip_6 == race_result.race_result_4
      points += 10
    elsif user_tip.race_tip_6 == race_result.race_result_5
      points += 12
    elsif user_tip.race_tip_6 == race_result.race_result_6
      points += 15
    elsif user_tip.race_tip_6 == race_result.race_result_7
      points += 12
    elsif user_tip.race_tip_6 == race_result.race_result_8
      points += 10
    elsif user_tip.race_tip_6 == race_result.race_result_9
      points += 8
    elsif user_tip.race_tip_6 == race_result.race_result_10
      points += 6
    end

    # Points for 7th in race
    if user_tip.race_tip_7 == race_result.race_result_1
      points += 4
    elsif user_tip.race_tip_7 == race_result.race_result_2
      points += 5
    elsif user_tip.race_tip_7 == race_result.race_result_3
      points += 6
    elsif user_tip.race_tip_7 == race_result.race_result_4
      points += 8
    elsif user_tip.race_tip_7 == race_result.race_result_5
      points += 10
    elsif user_tip.race_tip_7 == race_result.race_result_6
      points += 12
    elsif user_tip.race_tip_7 == race_result.race_result_7
      points += 15
    elsif user_tip.race_tip_7 == race_result.race_result_8
      points += 12
    elsif user_tip.race_tip_7 == race_result.race_result_9
      points += 10
    elsif user_tip.race_tip_7 == race_result.race_result_10
      points += 8
    end

    # Points for 8th in race
    if user_tip.race_tip_8 == race_result.race_result_1
      points += 3
    elsif user_tip.race_tip_8 == race_result.race_result_2
      points += 4
    elsif user_tip.race_tip_8 == race_result.race_result_3
      points += 5
    elsif user_tip.race_tip_8 == race_result.race_result_4
      points += 6
    elsif user_tip.race_tip_8 == race_result.race_result_5
      points += 8
    elsif user_tip.race_tip_8 == race_result.race_result_6
      points += 10
    elsif user_tip.race_tip_8 == race_result.race_result_7
      points += 12
    elsif user_tip.race_tip_8 == race_result.race_result_8
      points += 15
    elsif user_tip.race_tip_8 == race_result.race_result_9
      points += 12
    elsif user_tip.race_tip_8 == race_result.race_result_10
      points += 10
    end

    # Points for 9th in race
    if user_tip.race_tip_9 == race_result.race_result_1
      points += 2
    elsif user_tip.race_tip_9 == race_result.race_result_2
      points += 3
    elsif user_tip.race_tip_9 == race_result.race_result_3
      points += 4
    elsif user_tip.race_tip_9 == race_result.race_result_4
      points += 5
    elsif user_tip.race_tip_9 == race_result.race_result_5
      points += 6
    elsif user_tip.race_tip_9 == race_result.race_result_6
      points += 8
    elsif user_tip.race_tip_9 == race_result.race_result_7
      points += 10
    elsif user_tip.race_tip_9 == race_result.race_result_8
      points += 12
    elsif user_tip.race_tip_9 == race_result.race_result_9
      points += 15
    elsif user_tip.race_tip_9 == race_result.race_result_10
      points += 12
    end

        # Points for 10th in race
    if user_tip.race_tip_10 == race_result.race_result_1
      points += 1
    elsif user_tip.race_tip_10 == race_result.race_result_2
      points += 2
    elsif user_tip.race_tip_10 == race_result.race_result_3
      points += 3
    elsif user_tip.race_tip_10 == race_result.race_result_4
      points += 4
    elsif user_tip.race_tip_10 == race_result.race_result_5
      points += 5
    elsif user_tip.race_tip_10 == race_result.race_result_6
      points += 6
    elsif user_tip.race_tip_10 == race_result.race_result_7
      points += 8
    elsif user_tip.race_tip_10 == race_result.race_result_8
      points += 10
    elsif user_tip.race_tip_10 == race_result.race_result_9
      points += 12
    elsif user_tip.race_tip_10 == race_result.race_result_10
      points += 15
    end

    return points
  end

end
