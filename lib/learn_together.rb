require 'ostruct'
require "learn_together/version"
require 'learn_together/generator'
require 'active_support/core_ext/hash'

module LearnTogether
  class GroupMaker
    VALID_ARGS = {
      valid_keys: ["groups_of", "collection", "sort_type", "number_of_groups"],
      sort_type: ["random", "progress"]
      }

    attr_accessor :options

    def run(options)
      @options = ActiveSupport::HashWithIndifferentAccess.new(options)
      validate_args
      students = Student.new(options[:collection]).generate_batch_students
      generator = Generator.new(students: students, groups_of: options[:groups_of], number_of_groups: options[:number_of_groups], sort_type: options[:sort_type])
      generator.make_groups
    end

    def validate_args
      (has_valid_keys? && has_valid_values?) ? true : (raise GroupMakerArgError.new)
    end

    def has_valid_keys?
      options.keys.all? {|key| VALID_ARGS[:valid_keys].include?(key)}
    end
    
    def has_valid_values?
      if options["sort_type"] 
        if VALID_ARGS[:sort_type].include?(options["sort_type"])
          true
        else
          false
        end
      else
        true
      end
    end
  end

  class GroupMakerArgError < StandardError
    def initialize(msg="must pass arguments of: student collection, groups_of (i.e. groups_of: 4), sort_type (i.e. sort_type: 'random') OR student collection and number of groups (i.e. number_of_groups: 3)")
      super
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
      collection.first.is_a?(Hash) && (collection.first.keys.include?("completed_lesson_count_for_active_track" || :completed_lesson_count_for_active_track))
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

