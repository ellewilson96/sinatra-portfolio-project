class FlightController < ApplicationController

  get '/flights/new' do
    erb :'/flights/create_flight'
  end

end
