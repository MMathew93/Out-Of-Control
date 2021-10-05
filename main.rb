# frozen_string_literal: true

require 'app/character.rb'
require 'app/game_board.rb'
# Main Game Class to run/execute

class Game
  def initialize(args)
    @args = args
    @character = Character.new(args)
    @board = GameBoard.new(args)
    @player_rect = {
                    x: @character.player_x_position, y: @character.player_y_position, 
                    w: @character.player_w, h: @character.player_h
                  }
    @exit_rect = {
                  x: @board.exit_x_position, y: @board.exit_y_position, 
                  w: @board.exit_w, h: @board.exit_h
                }
  end

  def render
    @board.draw
    @character.draw
  end

  def game_state
    @args.outputs.labels << [640, 400, 'Next Level', 100, 1, 0, 255, 0] if @player_rect.intersect_rect? @exit_rect
    @args.outputs.labels << [640, 400, 'GAME OVER', 100, 1, 0, 255, 0] if @board.time <= 0
  end

  def tick
    render
    @character.move
    game_state
  end
end

def tick(args)
  args.state.game ||= Game.new(args)
  args.state.game.tick
end
