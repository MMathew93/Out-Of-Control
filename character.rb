class Character
  def initialize(args)
    @args = args
    @player_x_position = 200
    @player_y_position = 600
    @player_w = 35
    @player_h = 35
    @directions = [method(:left), method(:up), method(:right), method(:down)]
  end

  def draw
    @args.outputs.solids << [@player_x_position, @player_y_position, @player_w, @player_h, 255, 0, 0, 255]
  end

  def move
    k = @args.inputs.keyboard
    c = @args.inputs.controller_one

    # Can I make this a case statement later?
    if k.key_held.left
      @directions[0].call
    end

    if k.key_held.up
      @directions[1].call
    end

    if k.key_held.right
      @directions[2].call
    end

    if k.key_held.down
      @directions[3].call
    end
  end

  def left
    @player_x_position -= 1 unless @player_x_position  < 0
  end
  def up
    @player_y_position += 1 unless @player_y_position > (720 - @player_h)
  end
  def right
    @player_x_position  += 1 unless @player_x_position  > (1280 - @player_w)
  end
  def down
    @player_y_position -= 1 unless @player_y_position < 0
  end

end