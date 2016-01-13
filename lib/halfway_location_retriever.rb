require 'method_object'
require_relative 'halfway_calculator'

HalfwayLocationRetriever = MethodObject.new(:event, :search_param) do
  def call
    {
      meeting_point: yelp_client_result.name,
      address: yelp_location_data.address.first,
      latitude: yelp_location_data.coordinate.latitude,
      longitude: yelp_location_data.coordinate.longitude,
      image: yelp_client_result.image_url,
    }
  end

  def yelp_location_data
    @yelp_location_data ||= yelp_client_result.location
  end

  def yelp_client_result
    @yelp_client_result ||= Yelp.client.search_by_coordinates(
      coordinates,
      params,
    ).businesses[0]
  end

  def coordinates
    HalfwayCalculator.call(event: event)
  end

  def params
    {
      term: search_param,
      limit: 1,
    }
  end
end
