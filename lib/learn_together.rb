require 'ostruct'
require "learn_together/version"
require 'learn_together/generator'

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

    def generate_batch_students
      if student_hash_type
        return collection.collect {|s| OpenStruct.new(s)}
      elsif student_instance_object_type
        return collection
      else
        raise StudentTypeError.new
      end
    end

    def student_hash_type
      collection.first.respond_to?(:[]) && collection.first[:completed_lesson_for_active_track_count]
    end

    def student_instance_object_type
      collection.first.respond_to?(:completed_lesson_count_for_active_track)
    end
  end

  class StudentTypeError < StandardError
    def initialize(msg="student collection must contain student objects that respond to a #completed_lesson_count_for_active_track method or have a key of :completed_lesson_count_for_active_track_count")
      super
    end
  end
end


# LearnTogether::GroupMaker.run(collection: students, group_type: "table", sort_type: "random")