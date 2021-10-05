# frozen_string_literal: true

# Player controls and interaction class

class Character
  attr_accessor :player_x_position, :player_y_position, :player_w, :player_h

  def initialize(args)
    @args = args
    @player_x_position = 100
    @player_y_position = 510
    @player_w = 50
    @player_h = 50
    @directions = [method(:left), method(:up), method(:right), method(:down)]
  end

  def draw
    @args.outputs.solids << [@player_x_position, @player_y_position, @player_w, @player_h, 255, 0, 0, 255]
  end

  def move
    k = @args.inputs.keyboard
    c = @args.inputs.controller_one

    # Can I make this a case statement later?
    @directions[0].call if k.key_held.left

    @directions[1].call if k.key_held.up

    @directions[2].call if k.key_held.right

    @directions[3].call if k.key_held.down
  end

  def left
    @player_x_position -= 2 unless @player_x_position < 70
  end

  def up
    @player_y_position += 2 unless @player_y_position > 530
  end

  def right
    @player_x_position += 2 unless @player_x_position > 1160
  end

  def down
    @player_y_position -= 2 unless @player_y_position < 70
  end
end
