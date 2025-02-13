module Projects
  class AssignUser
    def initialize(project_id, user_id, add_new = true)
      @project_id = project_id
      @user_id = user_id
      @add_new = add_new
    end

    def call
      # let the service raise error
      project_user = ProjectUser.find_or_initialize_by(user_id: @user_id, project_id: @project_id)
      if @add_new
        project_user.update(deleted_at: nil) unless project_user.new_record?
        project_user.save
        project_user.project
      else
        project_user.soft_delete
      end
    end
  end
end
