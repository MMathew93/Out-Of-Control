class Character
  def initialize(args)
    @args = args
    @directions = {left: 'a', up: 'w', right: 'd', down: 's'}
  end

  def render
    @player = @args.outputs.solids << [200, 600, 35, 35, 255, 0, 0, 255]
  end

  def tick
    render
  end
end