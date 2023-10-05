class V1::RecordsController < ApplicationController
  def index
    # render json: Log.all
    render json: @current_user.records
  end

  def create
    record = @current_user.records.new(record_params)
    if record.save
      render json: record, status: :created, location: [:v1, record]
    else
      render json: record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    id = params[:id]
    if record = @current_user.records.find_by(id: id)    
      record.destroy
      render json: { id: id }
    else
      render json: { error: 'Cant find the record with id: ' + id }, status: 404
    end
  end
  private
  def record_params
    params.require(:record).permit(:recorded_on, :weight, image: {})
  end
end