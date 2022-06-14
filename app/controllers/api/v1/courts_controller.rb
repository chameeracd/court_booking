class Api::V1::CourtsController < ApplicationController
  # GET /courts
  def index
    @courts = Court.all
    render json: @courts
  end

  # GET  /court/:id
  def show
    @court = Court.find(params[:id])
    render json: @court
  end

  # POST /courts
  def create
    @court = Court.new(court_params)
    if @court.save
      render json: @court
    else
      render error: { error: 'Unable to create Court.' }, status: 400
    end
  end

  # PUT /courts/:id
  def update
    @court = Court.find(params[:id])
    if @court
      @court.update(court_params)
      render json: { message: 'Court successfully update. ' }, status: 200
    else
      render json: { error: 'Unable to update court. ' }, status: 400
    end
  end

  # DELETE /courts/:id
  def destroy
    @court = Court.find(params[:id])
    if @court
      @court.destroy
      render json: { message: 'Court successfully deleted. ' }, status: 200
    else
      render json: { error: 'Unable to delete Court. ' }, status: 400
    end
  end

  private def court_params
    params.require(:court).permit(:name, :code, :type)
  end
end
