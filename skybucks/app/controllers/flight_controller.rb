class FlightController < ApplicationController

  get '/flights' do
  if logged_in?
        @flights = current_user.flights.all
        erb :'flights/flights'
      else
        redirect to '/login'
      end
    end

    get '/flights/new' do
      if logged_in?
        erb :'flights/create_flight'
      else
        redirect to '/login'
      end
    end

    get '/flights/error' do
      erb :'/flights/error'
    end

    post '/flights' do
     if logged_in?
       if params[:origin] == params[:destination]
         erb :'/flights/create_flight', locals: {message: "Origin and Destination cannot be the same. Please choose another option."}
       else
         @flight = current_user.flights.build(origin: params[:origin], destination: params[:destination], user_id: params[:user_id])
          if params[:origin] != params[:destination]
            @flight.save
           redirect to "/flights/#{@flight.id}"
         else
           redirect to "/flights/new"
         end
       end
       else
       redirect to '/'
     end
   end

   get '/flights/:id' do
     if logged_in?
       @flight = Flight.find_by_id(params[:id])
       if @flight && @flight.user == current_user
         erb :'flights/show_flight'
       else
       redirect to '/flights'
      end
    else
      redirect to '/login'
   end
 end

   get '/flights/:id/edit' do
     if logged_in?
       @flight = Flight.find_by_id(params[:id])
       if @flight && @flight.user == current_user
         erb :'flights/edit_flight'
       else
         redirect to '/flights'
       end
     else
       redirect to '/login'
     end
   end

   patch '/flights/:id' do
     if logged_in?
       if params == ""
         redirect to "/flights/#{params[:id]}/edit"
       else
         @flight = Flight.find_by_id(params[:id])
         if @flight && @flight.user == current_user
           if @flight.update(origin: params[:origin], destination: params[:destination])
             redirect to "/flights/#{@flight.id}"
           else
             redirect to "/flights/#{@flight.id}/edit"
           end
         else
           redirect to '/flights'
         end
       end
     else
       redirect to '/login'
     end
   end

   delete '/flights/:id/delete' do
     if logged_in?
       @flight = Flight.find_by_id(params[:id])
       if @flight && @flight.user == current_user
         @flight.delete
       end
       redirect to '/flights'
     else
       redirect to '/login'
     end
   end
end
