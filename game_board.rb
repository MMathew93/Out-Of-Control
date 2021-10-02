class GameBoard

  def initialize(args)
    @args = args
  end

  def draw
    render_background
  end

  def render_play_area
    @args.outputs.solids << [50, 50, 1180, 550, 0, 0, 0]
    @args.outputs.solids << [70, 70, 1140, 510, 255, 255, 255]
  end

  def render_timer
    @args.outputs.labels << [640, 700, 20.0, 25, 1, 0, 0, 0]
  end

  def render_background
    render_timer
    render_play_area
  end
end