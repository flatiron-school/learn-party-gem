require 'OStruct'
require "learn_together/version"

module LearnTogether
  class GroupMaker
    def self.run(collection:, groups_of:, sort_type:)
      students = Student.new(collection).generate_batch_students
      @generator = Generator.new(students: students, groups_of: groups_of, sort_type: sort_type)
      @generator.make_groups
    end
  end

  class Student
    attr_accessor :collection

    def initialize(collection)
      @collection = collection
    end

    def generate_batch_students(collection)
      if incorrect_student_object_types
        raise StandardError.new
      elsif student_hash_type
        return collection.collect {|s| OpenStruct.new(s)}
      elsif student_instance_object_type
        return collection
      end
    end

    def incorrect_student_object_types
      !collection.first.respond_to?(:completed_lesson_for_active_track_count) && collection.first[:completed_lesson_for_active_track_count].nil?
    end

    def student_hash_type
      !collection.first.respond_to?(:completed_lesson_for_active_track_count) && collection.first[:completed_lesson_for_active_track_count]
    end

    def student_instance_object_type
      collection.first.respond_to?(:completed_lesson_for_active_track_count)
    end
  end

  class StudentTypeError < StandardError
    def initialize(msg="student collection must contain student objects that respond to a #completed_lesson_for_active_track_count method or have a key of :completed_lesson_for_active_track_count")
      super
    end
  end
end


# LearnTogether::GroupMaker.run(collection: students, group_type: "table", sort_type: "random")