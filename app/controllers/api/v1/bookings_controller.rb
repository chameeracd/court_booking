class Api::V1::BookingsController < ApplicationController

  #POST /bookings/book/
  def book
    @customer = Customer.find(params[:customer])
    @court = Court.find_by_code(params[:court])
    @time = Time.parse(params[:time])
    duration = Time.parse("01:00:00").seconds_since_midnight.seconds
    @to = @time + duration
    @booked = []

    if @customer && @court && (params[:time] < @to)
      @booked = Booking.where("((`from` <= :from AND :from < `to`)
                                  OR (`from` < :to AND :to <= `to`)
                                  OR (:from <= `from` AND `from` < :to))
                                  AND court_id = :court",
                              { from: params[:time], to: @to, court: @court.id }).limit(1)
      if @booked.count == 0
        @booking = Booking.new(
          :customer => @customer,
          :court => @court,
          :from => params[:time],
          :to => @to
        )
        if @booking.save
          render json: @booking
        else
          render json: { error: 'Unable to create Booking.' }, status: 400
        end
      else
        render json: { error: "Court #{@court.name} not available" }, status: 400
      end
    else
      render error: { error: "invalid data" }, status: 400
    end
  end

  # GET /bookings
  def index
    @bookings = Booking.all
    render json: @bookings
  end

  # GET  /booking/:id
  def show
    @booking = Booking.find(params[:id])
    render json: @booking
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      render json: @booking
    else
      render error: { error: 'Unable to create Booking.' }, status: 400
    end
  end

  # PUT /bookings/:id
  def update
    @booking = Booking.find(params[:id])
    if @booking
      @booking.update(booking_params)
      render json: { message: 'Booking successfully update. ' }, status: 200
    else
      render json: { error: 'Unable to update booking. ' }, status: 400
    end
  end

  # DELETE /bookings/:id
  def destroy
    @booking = Booking.find(params[:id])
    if @booking
      @booking.destroy
      render json: { message: 'Booking successfully deleted. ' }, status: 200
    else
      render json: { error: 'Unable to delete Booking. ' }, status: 400
    end
  end

  private def booking_params
    params.require(:booking).permit(:customer_id, :court_id, :from, :to)
  end
end
