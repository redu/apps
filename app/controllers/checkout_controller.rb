# encoding: utf-8

class CheckoutController < ApplicationController
  respond_to :js

  def update
    raise ActiveRecord::RecordNotFound unless App.find(params[:app_id])
    @app_id = params[:app_id]
    @app = App.find_by_id(@app_id)
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

  protected

  def step_1
    get_params([:previous_step], params)
    @environments = current_user.environments(include: { courses: :spaces })
    @next_step = 2

    respond_to do |format|
      format.js
    end
  end

  def step_2
    get_params([:space_id, :previous_step], params)
    @space = Space.find_by_id(@space_id)
    @next_step = 3

    respond_to do |format|
      format.js
    end
  end

  def step_3
    get_params([:space_id, :previous_step, :create_subject], params)
    @space = Space.find(@space_id)
    @next_step = 4

    respond_to do |format|
      format.js
    end
  end

  def step_4
    get_params([:space_id, :create_subject, :lecture, :subject], params)
    @subject = @create_subject == 'true' ? create_subject_via_api : Subject.find(@subject)
    create_lecture_via_api

    respond_to do |format|
      format.js
    end
  end

  def get_params(expected_params, params)
    expected_params.each do |p|
      self.instance_variable_set("@#{p}",
        params.fetch(p) { raise "Invalid State" })
    end
  end

  def create_subject_via_api
    response = Subject.create_via_api(space_sid: Space.find(@space_id).sid,
                                      subject: @subject, token: current_user.token)
    case response.status #TODO
    when 201
      subject = JSON.parse response.body

      Subject.new(name: subject['name'], suid: subject['id'])
    when 401 # Autenticação falhou
    when 422 # Criação falhou devido a erro na requisição
    else
      raise "Unknown status code #{response.status}"
    end
  end

  def create_lecture_via_api
    response = Lecture.create_via_api(lecture: @lecture, aid: @app.aid,
                                      subject_suid: @subject.suid,
                                      token: current_user.token)
    case response.status #TODO
    when 201
    when 401 # Autenticação falhou
    when 422 # Criação falhou devido a erro na requisição
    else
      raise "Unknown status code #{response.status}"
    end
  end
end
