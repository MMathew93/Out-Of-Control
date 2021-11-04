# frozen_string_literal: true

# Player controls and interaction class

class Character
  attr_accessor :player_x_position, :player_y_position, :player_w, :player_h

  def initialize(args)
    @args = args
    @player_x_position = 100
    @player_y_position = 510
    @player_w = 50
    @player_h = 65
    @walls = []
    @directions = [method(:left), method(:up), method(:right), method(:down)]
  end

  # function that dipslays/draws the player character
  def draw
    @args.outputs.primitives << {x: @player_x_position, y: @player_y_position, w: @player_w, h: @player_h, path: 'assets/astro-1.png'}.sprite!
  end

  # function that allows player to move
  def move(game_is_over)
    return if game_is_over
    k = @args.inputs.keyboard
    # Can I make this a case statement later?
    @directions[0].call if k.key_held.left

    @directions[1].call if k.key_held.up

    @directions[2].call if k.key_held.right

    @directions[3].call if k.key_held.down
  end

  def receive_walls(walls)
    @walls = walls
  end

  def receive_player_position(position)
    @player_rect = position
  end

  #checks to make sure player is still in the play area and not passed the game border
  #def player_in_play_area
    #return @player_rect.inside_rect?(@play_area)
  #end

  def wall_collide
    return if @walls.empty?
    colliding = false
    @walls.each do |wall|
      if @player_rect.intersect_rect?(wall)
        set_x(wall)
        #set_y(wall)
        colliding = true
        break
      end
    end
    return colliding
  end

  def set_x(wall)
    if @player_rect[:x] + @player_rect[:w] > wall[:x] && @player_rect[:x] < wall[:x]
      @player_x_position = wall[:x] - (@player_rect[:w] + 1)
    else
      @player_x_position = wall[:x] + 16
    end
  end

  def set_y(wall)
    #test
  end

  # functions to set new x and y positions based on key press, keeps player within play area
  def left
    @player_x_position -= 5 unless wall_collide || @player_x_position < 75
  end

  def up
    @player_y_position += 5 unless wall_collide || @player_y_position > 510
  end

  def right
    @player_x_position += 5 unless wall_collide || @player_x_position > 1155
  end

  def down
    @player_y_position -= 5 unless wall_collide || @player_y_position < 75
  end

  # function that shuffles the players moves for the theme of game
  def shuffle_directions
    @directions = @directions.shuffle
  end

end
