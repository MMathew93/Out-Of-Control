# frozen_string_literal: true

require 'app/character.rb'
require 'app/game_board.rb'
# Main Game Class to run/execute

class Game
  def initialize(args)
    @args = args
    @board = GameBoard.new(args)
    @character = Character.new(args)
    @level = 1
    @game_scene = :menu
    @gameover = false
    @flag = false
  end

  def render
    render_menu
    render_game
  end

  def render_game
    return unless @game_scene == :game
    @board.draw(@level)
    @character.draw
    @character.move(@gameover)
    game_state
  end

  def render_menu
    return unless @game_scene == :menu
    @args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0, 200]

    @args.outputs.labels << [640, 600, "Out of Control", 50, 1, 255, 255, 255]
    @args.outputs.labels << [640, 400, "Instructions: Get to the exit!", 4, 1, 255, 255, 255]
    @args.outputs.labels << [500, 240, "[Enter] Start/Resume ", 4, 0, 255, 255, 255]
    @args.outputs.labels << [500, 270, "[R] Restart ", 4, 0, 255, 255, 255]
    @args.outputs.labels << [500, 300, "[Esc] Pause ", 4, 0, 255, 255, 255]

    @args.outputs.labels << [10, 100, "Code:   @MMathew93", 255, 255, 255]
    @args.outputs.labels << [10,  80, "Art:    etrujii.tumblr.com", 255, 255, 255]
    @args.outputs.labels << [10,  60, "Music:  'Crash Landing' DOS-88", 255, 255, 255]
    @args.outputs.labels << [10,  40, "Engine: DragonRuby GTK", 255, 255, 255]
  end

  def game_state
    @flag = false
    @player_rect = {
      x: @character.player_x_position, y: @character.player_y_position,
      w: @character.player_w, h: @character.player_h
    }
    @exit_rect = {
      x: @board.exit_x_position, y: @board.exit_y_position,
      w: @board.exit_w, h: @board.exit_h
    }
    @character.receive_player_position(@player_rect)
    next_level if @player_rect.intersect_rect?(@exit_rect)
    if @board.time <= 0
      @gameover = true
      @board.game_over?
    elsif @level > 3
      @gameover = true
      @board.game_over?
    end
  end

  def next_level
    @level += 1
    @board.time = 20
    @character.shuffle_directions
    @flag = true
    
    if @level.even?
      @board.exit_x_position = 85
      @board.exit_y_position = 510
      @character.player_x_position = 1140
      @character.player_y_position = 90
    else
      @board.exit_x_position = 1135
      @board.exit_y_position = 75
      @character.player_x_position = 100
      @character.player_y_position = 510
    end
    #feed walls to player class
    @board.walls = []
    @character.receive_walls(@board.walls)

    @board.splash_screen(@level)
  end

  def process_inputs
    process_inputs_menu
    process_inputs_game
  end

  def process_inputs_game
    return unless @game_scene == :game
    k = @args.inputs.keyboard

    if k.key_down.escape
      @game_scene = :menu
    end

    if @gameover && k.key_down.space
      $gtk.reset
    end

    if k.key_down.r
      $gtk.reset
    end
  end

  def process_inputs_menu
    return unless @game_scene == :menu
    k = @args.inputs.keyboard

    if k.key_down.enter
      @game_scene = :game
    end
  end

  def flag_check
    sleep(4) if @flag
  end

  def tick
    flag_check
    render
    process_inputs
  end
end

def tick(args)
  if args.state.tick_count == 0
    args.outputs.sounds << 'assets/CrashLanding.ogg'
  end
  args.state.game ||= Game.new(args)
  args.state.game.tick
end