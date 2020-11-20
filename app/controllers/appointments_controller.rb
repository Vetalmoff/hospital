class AppointmentsController < ApplicationController


  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_doctors, :set_user_id, only: [:new, :create, :index, :update, :edit]
  before_action :authorized?, only: [:index]
  before_action :the_same_user?, only: [:show, :edit, :update, :destroy]


  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all.order(:start_time)
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    if params[:doctor_id]
      set_doctor_this_day_appointments
    end
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    puts appointment_params
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to certain_day_appointments_index_path(appointment_params), notice: 'Appointment was successfully created.' }
        # format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        # format.html { redirect_to new_appointment_path(appointment_params)  }
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

  def  set_doctors
    @doctors = Doctor.all.order(:name)
  end

  def set_user_id
    @user_id = session[:user_id]
  end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:start_time, :end_time, :doctor_id, :user_id, :date)
    end

  def set_doctor_this_day_appointments(date=Time.now())
    @appointments = Appointment.order(:start_time)

    year = date.year
    month = date.month
    day = date.day

    current_day = Time.new(year, month, day)
    next_day = current_day + 1.day

    @doctor = Doctor.find(params[:doctor_id])
    @doctor_this_day_appointments = @appointments.where([
                                                          "start_time > ? and start_time < ? and doctor_id = ?",
                                                          current_day, next_day, params[:doctor_id]
                                                        ])
  end

  def the_same_user?
    redirect_to '/welcome',
                alert: "Permission denied" unless
      is_admin? || current_user.id.to_s == Appointment.find_by_id(params[:id]).user_id.to_s
  end
end

