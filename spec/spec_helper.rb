$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../spec/support', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../spec/fixtures', __FILE__)
require 'learn_together'
require 'test_student'
require 'json'
require 'pry'


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
