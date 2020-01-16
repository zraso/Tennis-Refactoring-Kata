require './lib/player'

class TennisGame1

  attr_reader :current_player
  ## Player classes, which each store their own points and name
  ## Where do the methods live though e.g. scores, point difference, won point, advantage, win, normal scores? In player or Game?

  def initialize(player1Name, player2Name)
    @players = [Player.new(player1Name), Player.new(player2Name)]
  end

  def point_difference
   @players.first.points - @players.last.points
  end

  def won_point(playerName)
    @players.each do |player| 
      player.add_point if player.name == playerName
    end
  end

  def equal_scores
    {
      0 => "Love-All",
      1 => "Fifteen-All",
      2 => "Thirty-All",
    }.fetch(@players.first.points, "Deuce")
  end

  def advantage
    if (point_difference.positive?)
      "Advantage player1"
    else
      "Advantage player2"
    end
  end

  def win
    if (point_difference.positive?)
      "Win for player1"
    else
      "Win for player2"
    end
  end

  def normal_scores
    result = []
    @players.each do |player|
      result << {
        0 => "Love",
        1 => "Fifteen",
        2 => "Thirty",
        3 => "Forty",
      }[player.points]
    end

    result.join("-")
  end
  
  def score
    if players_equal?
      equal_scores
    elsif advantage?
      advantage
    elsif win?
      win
    else
      normal_scores
    end
  end
end

def players_equal?
  @players.first.points==@players.last.points
end

def players_equal?
  @players.first.points==@players.last.points
end

def advantage?
  over_four_points? && ((point_difference==1) || (point_difference==-1))
end

def win?
  over_four_points? && ((point_difference>=2) || (point_difference<=-2))
end

def over_four_points?
  @players.first.points>=4 or @players.last.points>=4
end


class TennisGame2
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end
      
  def won_point(playerName)
    if playerName == @player1Name
      p1Score()
    else
      p2Score()
    end
  end

  def score
    result = ""
    if (@p1points == @p2points and @p1points < 3)
      if (@p1points==0)
        result = "Love"
      end
      if (@p1points==1)
        result = "Fifteen"
      end
      if (@p1points==2)
        result = "Thirty"
      end
      result += "-All"
    end
    if (@p1points==@p2points and @p1points>2)
        result = "Deuce"
    end
    
    p1res = ""
    p2res = ""
    if (@p1points > 0 and @p2points==0)
      if (@p1points==1)
        p1res = "Fifteen"
      end
      if (@p1points==2)
        p1res = "Thirty"
      end
      if (@p1points==3)
        p1res = "Forty"
      end
      p2res = "Love"
      result = p1res + "-" + p2res
    end
    if (@p2points > 0 and @p1points==0)
      if (@p2points==1)
        p2res = "Fifteen"
      end
      if (@p2points==2)
        p2res = "Thirty"
      end
      if (@p2points==3)
        p2res = "Forty"
      end
      
      p1res = "Love"
      result = p1res + "-" + p2res
    end
    
    if (@p1points>@p2points and @p1points < 4)
      if (@p1points==2)
        p1res="Thirty"
      end
      if (@p1points==3)
        p1res="Forty"
      end
      if (@p2points==1)
        p2res="Fifteen"
      end
      if (@p2points==2)
        p2res="Thirty"
      end
      result = p1res + "-" + p2res
    end
    if (@p2points>@p1points and @p2points < 4)
      if (@p2points==2)
        p2res="Thirty"
      end
      if (@p2points==3)
        p2res="Forty"
      end
      if (@p1points==1)
        p1res="Fifteen"
      end
      if (@p1points==2)
        p1res="Thirty"
      end
      result = p1res + "-" + p2res
    end
    if (@p1points > @p2points and @p2points >= 3)
      result = "Advantage " + @player1Name
    end
    if (@p2points > @p1points and @p1points >= 3)
      result = "Advantage " + @player2Name
    end
    if (@p1points>=4 and @p2points>=0 and (@p1points-@p2points)>=2)
      result = "Win for " + @player1Name
    end
    if (@p2points>=4 and @p1points>=0 and (@p2points-@p1points)>=2)
      result = "Win for " + @player2Name
    end
    result
  end

  def setp1Score(number)
    (0..number).each do |i|
        p1Score()
    end
  end

  def setp2Score(number)
    (0..number).each do |i|
      p2Score()
    end
  end

  def p1Score
    @p1points +=1
  end
  
  def p2Score
    @p2points +=1
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end
      
  def won_point(n)
    if n == @p1N
        @p1 += 1
    else
        @p2 += 1
    end
  end
  
  def score
    if (@p1 < 4 and @p2 < 4) and (@p1 + @p2 < 6)
      p = ["Love", "Fifteen", "Thirty", "Forty"]
      s = p[@p1]
      @p1 == @p2 ? s + "-All" : s + "-" + p[@p2]
    else
      if (@p1 == @p2)
        "Deuce"
      else
        s = @p1 > @p2 ? @p1N : @p2N
        (@p1-@p2)*(@p1-@p2) == 1 ? "Advantage " + s : "Win for " + s
      end
    end
  end
end
