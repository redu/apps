
class CheckoutController < ApplicationController

  def update
    @app_id = params[:app_id]
    case params[:step]
    when '1'
      step_1
    when '2'
      step_2
    when '3'
      step_3
    when '4'
      step_4
    else
      step_1
    end

  end

  def new
    @app_id = params[:app_id]
    step_1
  end

  protected

  def step_1
    @user = current_user
    @next_step = 2
    render :step1
  end

  def step_2
    @space = params.fetch(:space_id) { raise "Invalid State" }
    @next_step = 3
    render :step2
  end

  def step_3
    space_id = params.fetch(:space_id) { raise "Invalid State" }
    @space = Space.find(space_id)
    @create_module = params.fetch(:create_module) { raise "Invalid State" }
    @next_step = 4
    render :step3
  end

  def step_4
    @space = params.fetch(:space_id) { raise "Invalid State" }
    create_module = params.fetch(:create_module) { raise "Invalid State" }
    @aula = params.fetch(:aula) { raise "Invalid State" }
    @modulo = params.fetch(:subject) { raise "Invalid State" }

    @modulo = if create_module == 'true'
      Subject.create(:name => @modulo) { |s| s.space = Space.find(@space) }
    else
      Subject.find(@modulo)
    end
    Lecture.create(:name => @aula) do |l|
      l.subject = Subject.find(@modulo)
      l.app = App.find(@app_id)
    end
    redirect_to app_path(@app_id)
  end
end
