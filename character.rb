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
    @directions = [method(:left), method(:up), method(:right), method(:down)]
  end

  # function that dipslays/draws the player character
  def draw
    @args.outputs.sprites << [@player_x_position, @player_y_position, @player_w, @player_h, 'assets/astro-1.png']
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

  def receive_variables(player_rect, walls)
    @player_rect = player_rect
    @walls = walls
  end

  # functions to set new x and y positions based on key press, keeps player within play area
  def left
    colliding = false
    @walls.each do |wall|
      if @player_rect.intersect_rect?(wall)
        colliding = true
        break
      end
    end
    @player_x_position -= 4 unless colliding
  end

  def up
    colliding = false
    @walls.each do |wall|
      if @player_rect.intersect_rect?(wall)
        colliding = true
        break
      end
    end
    @player_y_position += 4 unless colliding
  end

  def right
    colliding = false
    @walls.each do |wall|
      if @player_rect.intersect_rect?(wall)
        colliding = true
        break
      end
    end
    @player_x_position += 4 unless colliding
    puts @walls
  end

  def down
    colliding = false
    @walls.each do |wall|
      if @player_rect.intersect_rect?(wall)
        colliding = true
        break
      end
    end
    @player_y_position -= 4 unless colliding
  end

  # function that shuffles the players moves for the theme of game
  def shuffle_directions
    @directions = @directions.shuffle
  end

end
