$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../spec/support', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../spec/fixtures', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../spec/shared_examples', __FILE__)
require 'learn_together'
require 'test_student'
require 'json'
require 'pry'
file_path = File.expand_path('../../spec/shared_examples', __FILE__)
Dir["#{file_path}/*.rb"].sort.each { |f| require f}


def collection_of_student_objects
  student_hashes = load_student_json
  student_hashes["users"].collect do |s|
    TestStudent.new(s)
  end
end

def collection_of_student_hashes
  load_student_json["users"]
end

def load_student_json
  f = File.open(File.expand_path ("../learn_together") + '/spec/fixtures/batch_students.json')
  json = JSON.load(f)
  JSON.parse(json)
end


def calculate_sorted_lesson_counts(groups)
  groups.collect {|group| group.collect {|s| get_student_lesson_count(s)}}
end

def get_student_lesson_count(student)
  student.respond_to?(:completed_lesson_count_for_active_track) ? student.completed_lesson_count_for_active_track : student["completed_lesson_count_for_active_track"]
end

def groups_of_two_sorted_lesson_counts
  [[1, 1], [2, 3],[3, 3],[4, 4],[4, 4],[4, 5],[5, 5],[6, 6],[7, 7],[7, 7],[7, 7],[7, 8],[8, 8],[8, 8],[9, 9],[9, 10],[10, 10, 10]]
end

def groups_of_three_sorted_lesson_counts
  [[1, 1, 2], [3, 3, 3], [4, 4, 4], [4, 4, 5], [5, 5, 6], [6, 7, 7], [7, 7, 7], [7, 7, 8], [8, 8, 8], [8, 9, 9], [9, 10, 10], [10, 10]]
end

def groups_of_four_sorted_lesson_counts
  [[1, 1, 2, 3], [3, 3, 4, 4], [4, 4, 4, 5], [5, 5, 6, 6], [7, 7, 7, 7], [7, 7, 7, 8], [8, 8, 8, 8], [9, 9, 9, 10], [10, 10, 10]]
end
