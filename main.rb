# frozen_string_literal: true

require 'app/character.rb'
require 'app/game_board.rb'
# Main Game Class to run/execute

class Game
  def initialize(args)
    @args = args
    @character = Character.new(args)
    @board = GameBoard.new(args)
  end

  def render
    @board.draw
    @character.draw
  end

  def game_over
    if @board.instance_variable_get(:@time) <= 0
      @args.outputs.labels << [640, 400, 'GAME OVER', 100, 1, 0, 255, 0]
    elsif (@character.instance_variable_get(:@player_x_position) == @board.instance_variable_get(:@exit_x_position)) || (@character.instance_variable_get(:@player_y_position) === @board.instance_variable_get(:@exit_y_position))
      @args.outputs.labels << [640, 400, 'GAME OVER', 100, 1, 0, 255, 0]
    else
      # next level/restart methods
      @args.outputs.labels << [640, 400, 'YOU DID IT', 100, 1, 0, 255, 0]
    end
  end

  def tick
    render
    @character.move
    game_over
  end
end

def tick(args)
  args.state.game ||= Game.new(args)
  args.state.game.tick
end
