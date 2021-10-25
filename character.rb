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

  # functions to set new x and y positions based on key press, keeps player within play area
  def left
    @player_x_position -= 4 unless @player_x_position < 70
  end

  def up
    @player_y_position += 4 unless @player_y_position > 530
  end

  def right
    @player_x_position += 4 unless @player_x_position > 1160
  end

  def down
    @player_y_position -= 4 unless @player_y_position < 70
  end

  # function that shuffles the players moves for the theme of game
  def shuffle_directions
    @directions = @directions.shuffle
  end
end
