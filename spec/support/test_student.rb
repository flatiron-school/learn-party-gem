class TestStudent
  attr_accessor :first_name, :last_name, :github_username, :completed_lesson_count_for_active_track

  def initialize(options)
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @github_username = options["github_username"]
    @completed_lesson_count_for_active_track = options["completed_lesson_count_for_active_track"]
  end
end