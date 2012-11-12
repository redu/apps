require 'base_model'

class UserCourseAssociation < ActiveRecord::Base
  include BaseModel
  zombify
  attr_accessible :ucaid, :user
  belongs_to :user
  belongs_to :course
  as_enum :role, environment_admin: 3 , teacher:  5, member: 2, admin: 1, tutor: 6,
    course_admin: 4
end
