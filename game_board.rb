# frozen_string_literal: true

# Main gameboard class, controls the play area, timer, and exit

class GameBoard
  attr_accessor :time, :exit_x_position, :exit_y_position, :exit_w, :exit_h, :walls

  def initialize(args)
    @args = args
    @time = 20
    @exit_x_position = 1140
    @exit_y_position = 90
    @exit_w = 70
    @exit_h = 70
    @walls = []
  end

  # function that pulls everything together
  def draw(level)
    render_play_area(level)
    render_exit
    render_timer
  end

  # function that draws the "border" and player's interactive area
  def render_play_area(level)
    #return
    draw_walls(50, 50, 1180, 550)
    draw_walls(70, 70, 1140, 510, [255, 255, 255])
    #@args.outputs.primitives << [70, 70, 1140, 510, 'assets/bg.png'].sprite
    if level == 2
      draw_walls(180, 360, 15, 220, [])
      draw_walls(640, 400, 15, 200, [])
      draw_walls(535, 170, 15, 300, [])
      draw_walls(640, 50, 15, 200, [])
      draw_walls(745, 170, 15, 300, [])
      draw_walls(1100, 50, 15, 220, [])
      save_walls(level) if @walls.empty?
    end
    if level == 3
      draw_walls(180, 150, 15, 430, [255,0,0])
      draw_walls(290, 70, 15, 430, [])

      draw_walls(430, 60, 15, 220, [])
      draw_walls(430, 370, 15, 220, [])

      draw_walls(640, 360, 15, 220, [])
      draw_walls(550, 170, 15, 300, [])
      draw_walls(640, 60, 15, 220, [])
      draw_walls(730, 170, 15, 300, [])

      draw_walls(860, 60, 15, 220, [])
      draw_walls(860, 370, 15, 220, [])

      draw_walls(990, 150, 15, 430, [])
      draw_walls(1100, 50, 15, 430, [])
      save_walls(level) if @walls.empty?
    end
  end

  def save_walls(level)
    if level == 2
      @walls << [180, 360, 16, 220]
      @walls << [640, 400, 16, 200]
      @walls << [535, 170, 16, 300]
      @walls << [640, 50, 16, 200]
      @walls << [745, 170, 16, 300]
      @walls << [1100, 50, 16, 220]
    end
    if level == 3
      @walls << [180, 150, 16, 430]
      @walls << [290, 70, 16, 430]

      @walls << [430, 60, 16, 220]
      @walls << [430, 370, 16, 220]

      @walls << [640, 360, 16, 220]
      @walls << [550, 170, 16, 300]
      @walls << [640, 60, 16, 220]
      @walls << [730, 170, 16, 300]

      @walls << [860, 60, 16, 220]
      @walls << [860, 370, 16, 220]

      @walls << [990, 150, 16, 430]
      @walls << [1100, 50, 16, 430]
    end
  end

  # function that creates the exit sprite and it's location
  def render_exit
    @args.outputs.sprites << [@exit_x_position, @exit_y_position, @exit_w, @exit_h, 'assets/spiral.png']
  end

  # function that creates the timer and countsdown
  def render_timer
    @args.outputs.labels << [640, 700, (@time * 1).to_sf, 25, 1, 0, 0, 0]
    count_down
  end

  # function that counts the timer down
  def count_down
    @time -= (1 / 60) unless @time <= 0
  end

  # function for the pause screen between levels to explain new rules to player
  def splash_screen(level)
    if level == 2
      @args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0, 125]
      @args.outputs.solids << [70, 70, 1140, 510, 0, 0, 0, 200]
      @args.outputs.labels << [640, 459, "Oh snap, the controls are out of control!", 15, 1, 255, 255, 255]
      @args.outputs.labels << [640, 399, "Let's up the difficulty shall we?", 15, 1, 255, 255, 255]
    elsif level == 3
      @args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0, 125]
      @args.outputs.solids << [70, 70, 1140, 510, 0, 0, 0, 200]
      @args.outputs.labels << [640, 459, "Oooo you think your hot stuff huh?", 15, 1, 255, 255, 255]
      @args.outputs.labels << [640, 399, "Why not try the ULTIMATE CHALLENGE NEXT! >:]", 15, 1, 255, 255, 255]
    end
  end

  def draw_walls(x, y, width, height, color=[0,0,0])
    @args.outputs.solids << [x, y, width, height, *color]
  end

  def game_over?
    @time = 0
    @args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0, 125]
    @args.outputs.labels << [640, 469, 'GAME OVER', 100, 1, 255, 255, 255] 
    @args.outputs.labels << [640, 250, 'Hit Spacebar to Restart and Try again!', 10, 1, 255, 255, 255] 
  end
end
