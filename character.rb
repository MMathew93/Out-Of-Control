class Character
  def initialize(args)
    @args = args
    @directions = {left: 'a', up: 'w', right: 'd', down: 's'}
    @player_x_position = 200
    @player_y_position = 600
    @player_w = 35
    @player_h = 35
  end

  def draw
    @args.outputs.solids << [@player_x_position, @player_y_position, @player_w, @player_h, 255, 0, 0, 255]
  end

  def move
    k = @args.inputs.keyboard
    c = @args.inputs.controller_one

    # Can I make this a case statement later?
    if k.key_held.left
      @player_x_position -= 1 unless @player_x_position < 0
    end

    if k.key_held.up
      @player_y_position += 1 unless @player_y_position > (720 - @player_h)
    end

    if k.key_held.right
      @player_x_position += 1 unless @player_x_position > (1280 - @player_w)
    end

    if k.key_held.down
      @player_y_position -= 1 unless @player_y_position < 0
    end
  end

end