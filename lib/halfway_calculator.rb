require 'method_object'

HalfwayCalculator = MethodObject.new(:event) do
  def call
    {
      latitude: event.users.average(:latitude),
      longitude: event.users.average(:longitude),
    }
  end
end
