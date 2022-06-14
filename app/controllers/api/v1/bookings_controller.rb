class Api::V1::BookingsController < ApplicationController

  #POST /courts/book
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
                                  AND court_id = :court AND status = 'CONFIRMED'",
                              { from: params[:time], to: @to, court: @court.id }).limit(1)
      if @booked.count == 0
        @booking = Booking.new(
          :customer => @customer,
          :court => @court,
          :from => params[:time],
          :to => @to,
          :status => 'CONFIRMED'
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

  #POST /courts/booked
  def booked
    from = params[:date] + ' 00:00:00+00:00'
    to = params[:date] + ' 23:59:59+00:00'
    @booked = Booking.where("((`from` >= :from AND `to` <= :to))
                                  AND status = 'CONFIRMED'",
                            { from: from, to: to})

    render json: @booked
  end

  #POST /courts/cancel
  def cancel
    @booking = Booking.find(params[:id])
    if @booking
      @booking.update(:status => 'CANCELLED')
      render json: { message: 'Booking successfully cancelled. ' }, status: 200
    else
      render json: { error: 'Unable to update booking. ' }, status: 400
    end
  end

end
