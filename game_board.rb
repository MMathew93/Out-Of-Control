# frozen_string_literal: true

# Main gameboard class, controls the play area, timer, and exit

class GameBoard
  attr_accessor :time, :exit_x_position, :exit_y_position, :exit_w, :exit_h

  def initialize(args)
    @args = args
    @time = 20
    @exit_x_position = 1140
    @exit_y_position = 90
    @exit_w = 50
    @exit_h = 50
  end

  def draw
    render_background
    render_timer
    render_exit
  end

  def render_play_area
    @args.outputs.solids << [50, 50, 1180, 550, 0, 0, 0]
    @args.outputs.solids << [70, 70, 1140, 510, 255, 255, 255]
  end

  def render_timer
    @args.outputs.labels << [640, 700, @time.to_sf, 25, 1, 0, 0, 0]
    count_down
  end

  def count_down
    @time -= (1 / 60) unless @time <= 0
  end

  def render_background
    render_play_area
  end

  def render_exit
    @args.outputs.solids << [@exit_x_position, @exit_y_position, @exit_w, @exit_h, 0, 0, 255, 255]
  end
end
