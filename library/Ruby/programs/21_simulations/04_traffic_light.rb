# A traffic light state machine with a pedestrian button.
class TrafficLight
  DURATIONS = { green: 5, yellow: 2, red: 4, walk: 3 }.freeze
  NEXT = { green: :yellow, yellow: :red, red: :green, walk: :red }.freeze

  attr_reader :state

  def initialize
    @state = :red
    @remaining = DURATIONS[:red]
    @button = false
  end

  def press = @button = true

  def tick
    @remaining -= 1
    return unless @remaining.zero?
    @state = if @state == :red && @button
               @button = false
               :walk
             else
               NEXT[@state]
             end
    @remaining = DURATIONS[@state]
  end
end

light = TrafficLight.new
timeline = []
20.times do |t|
  light.press if t == 7
  timeline << light.state.to_s[0].upcase
  light.tick
end
puts timeline.join
puts timeline.chunk(&:itself).map { |s, run| "#{s}#{run.size}" }.join(" ")
