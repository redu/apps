
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
    @environments = current_user.environments(include: { courses: :spaces })
    @next_step = 2
    render :step1
  end

  def step_2
    get_params([:space_id], params)
    @next_step = 3
    render :step2
  end

  def step_3
    get_params([:space_id, :create_subject], params)
    @space = Space.find(@space_id)
    @next_step = 4
    render :step3
  end

  def step_4
    get_params([:space_id, :create_subject, :lesson, :subject], params)
    @subject = if @create_subject == 'true'
      Subject.create(name: @subject, space: Space.find(@space_id))
    else
      Subject.find(@subject)
    end
    lecture = Lecture.new(name: @lesson) do |l|
      l.subject = Subject.find(@subject)
      l.app = App.find(@app_id)
    end
    raise "Invalid data" unless lecture.save
    redirect_to app_path(@app_id)
  end

  def get_params(expected_params, params)
    expected_params.each do |p|
      self.instance_variable_set("@#{p}",
        params.fetch(p) { raise "Invalid State" })
    end
  end
end
