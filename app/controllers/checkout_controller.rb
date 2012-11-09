
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
    raise ActiveRecord::RecordNotFound unless App.find(params[:app_id])
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
    get_params([:space_id, :create_subject, :lecture, :subject], params)
    @app = App.find(@app_id)
    @subject = if @create_subject == 'true'
      create_subject_via_api
    else
      Subject.find(@subject)
    end
    create_lecture_via_api
    # lecture = Lecture.new(name: @lecture) do |l|
    #   l.subject = Subject.find(@subject)
    #   l.app = App.find(@app_id)
    # end
    # raise "Invalid data" unless lecture.save

    redirect_to app_path(@app)
  end

  def get_params(expected_params, params)
    expected_params.each do |p|
      self.instance_variable_set("@#{p}",
        params.fetch(p) { raise "Invalid State" })
    end
  end

  def create_subject_via_api
    response = Subject.create_via_api(space_id: @space_id, subject: @subject,
                                      token: current_user.token)
    case response.status #TODO
    when 201
      subject = JSON.parse response.body

      Subject.new(name: subject['name'], suid: subject['id'])
    when 401
    else
      raise "Unknown status code #{ response.status }"
    end
  end

  def create_lecture_via_api
    response = Lecture.create_via_api(lecture: @lecture, aid: @app.aid,
                                      subject_id: @subject.suid,
                                      token: current_user.token)
    case response.status #TODO
    when 201
    when 401
    else
      raise "Unknown status code #{ response.status }"
    end
  end
end
