require 'method_object'

HalfwayCalculator = MethodObject.new(:event) do
  def call
    {
      latitude: going_users.sum(&:latitude) / going_users.count,
      longitude: going_users.sum(&:longitude) / going_users.count,
    }
  end

  private

  def going_users
    User.accepted_event_invitation(event)
  end
end
