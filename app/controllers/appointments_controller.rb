class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :showcase]
  before_filter :disable_nav, only: [:showcase]
  before_filter :update_date_params, only: [:create, :update]

  # GET /appointments/list
  def list
    @appointments = Appointment.all_desc.paginate(:page => params[:page], :per_page => 15)
  end

  # GET /appointments/showcase
  def showcase
    @appointments = Appointment.all_showcase
  end

  # GET /appointments/help
  def help
  end

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    if params[:begin_date]
        begin_date = DateTime.parse(params[:begin_date])
        @appointment.begin_date = begin_date
        if params[:begin_date].include? "T"
          @appointment.begin_time = begin_date
        end
    end
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: t('.success') }
        format.json { render :show, status: :created, location: @appointment }
      else
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
        format.html { redirect_to @appointment, notice: t('.success') }
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
      format.html { redirect_to appointments_list_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:begin_date, :begin_time, :end_time, :external_participant_salutation, :external_participant_title, :external_participant_name, :external_participant_company, :clear_group_employee_salutation, :clear_group_employee_name)
    end

    # Convert default values for the year month and day field of a time object on appointment creation.
    def update_date_params
      if params[:appointment]
        begin_date = DateTime.strptime(params[:appointment][:begin_date], "%d.%m.%Y")
        params[:appointment]['begin_time(1i)'] = begin_date.year.to_s
        params[:appointment]['begin_time(2i)'] = begin_date.month.to_s
        params[:appointment]['begin_time(3i)'] = begin_date.mday.to_s
      end
    end
end
