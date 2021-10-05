# frozen_string_literal: true

require 'app/character.rb'
require 'app/game_board.rb'
# Main Game Class to run/execute

class Game
  def initialize(args)
    @args = args
    @character = Character.new(args)
    @board = GameBoard.new(args)
    @level = 1
  end

  def render
    @board.draw
    @character.draw
  end

  def game_state
    @player_rect = {
      x: @character.player_x_position, y: @character.player_y_position,
      w: @character.player_w, h: @character.player_h
    }
    @exit_rect = {
      x: @board.exit_x_position, y: @board.exit_y_position,
      w: @board.exit_w, h: @board.exit_h
    }
    next_level if @player_rect.intersect_rect?(@exit_rect)
    @board.game_over? if @board.time <= 0
  end

  def next_level
    @level += 1
    @board.time = 20
    @character.shuffle_directions
    if @level.even?
      @board.exit_x_position = 100
      @board.exit_y_position = 510
      @character.player_x_position = 1140
      @character.player_y_position = 90
    else
      @board.exit_x_position = 1140
      @board.exit_y_position = 90
      @character.player_x_position = 100
      @character.player_y_position = 510
    end
    # @board.splash_screen
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
