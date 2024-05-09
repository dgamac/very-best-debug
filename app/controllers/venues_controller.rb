class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    id = params.fetch("venue_id")
    @the_venue = Venue.where({ :id => id })[0]
    render({ :template => "venue_templates/details" })
  end

  def create
    @venue = Venue.new
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")

    if  @venue.valid?
      @venue.save
      redirect_to("/venues/#{@venue.id}", { :notice => "Venue posted successfully." })
    else
      redirect_to("/venues", { :notice => "Venue failed to post successfully." })
    end

  end
  
  def update
    the_id = params.fetch("venue_id")

    @venue = Venue.where({ :id => the_id })[0]
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")

      if  @venue.valid?
      @venue.save
      redirect_to("/venues/#{@venue.id}", { :notice => "Venue updated successfully." })
    else
      redirect_to("/venues", { :notice => "Venue failed to update successfully." })
    end
    
  end

  def destroy
    the_id = params.fetch("venue_id")
    @venue = Venue.where({ :id => the_id })[0]
    
    @venue.destroy

    redirect_to("/venues", { :notice => "Venue deleted successfully."} )
  end

end
