class ChangeDefaultFromZombie < ActiveRecord::Migration
  def up
    %w(spaces subjects user_course_associations user_environment_associations users courses environments).each do |table|

      change_column_default table, :zombie, true
    end
  end

  def down
    %w(spaces subjects user_course_associations user_environment_associations users courses environments).each do |table|

      change_column_default table, :zombie, nil
    end
  end
end
