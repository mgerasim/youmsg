class ActivatesController < ApplicationController
  before_action :set_activate, only: [:show, :edit, :update, :destroy]

  # GET /activates
  # GET /activates.json
  def index
    @activates = Activate.all
  end

  # GET /activates/1
  # GET /activates/1.json
  def show
  end

  # GET /activates/new
  def new
    @activate = Activate.new
  end

  # GET /activates/1/edit
  def edit
  end

  # POST /activates
  # POST /activates.json
  def create
    @activate = Activate.new(activate_params)

    respond_to do |format|
      if @activate.save
        format.html { redirect_to @activate, notice: 'Activate was successfully created.' }
        format.json { render :show, status: :created, location: @activate }
      else
        format.html { render :new }
        format.json { render json: @activate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activates/1
  # PATCH/PUT /activates/1.json
  def update
    respond_to do |format|
      if @activate.update(activate_params)
        format.html { redirect_to @activate, notice: 'Activate was successfully updated.' }
        format.json { render :show, status: :ok, location: @activate }
      else
        format.html { render :edit }
        format.json { render json: @activate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activates/1
  # DELETE /activates/1.json
  def destroy
    @activate.destroy
    respond_to do |format|
      format.html { redirect_to activates_url, notice: 'Activate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activate
      @activate = Activate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activate_params
      params.require(:activate).permit(:code, :phone, :status)
    end
end
