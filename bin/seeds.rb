require 'faker'
class TestStudent
  attr_accessor :first_name, :last_name, :github_username, :completed_lesson_count_for_active_track

  def initialize(options)
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @github_username = options["github_username"]
    @completed_lesson_count_for_active_track = options["completed_lesson_count_for_active_track"]
  end

  def self.fetch_students(num)
    student_array = []
    num.times do
      obj = {"first_name" => Faker::Name.first_name, "last_name" => Faker::Name.last_name, "github_username" => Faker::Name.last_name.downcase, "completed_lesson_count_for_active_track" => rand(1..10)}
      student_array.push(TestStudent.new(obj))
    end
    student_array
  end
end
