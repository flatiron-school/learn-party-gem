class Generator
  attr_accessor :students, :groups_of, :sort_type, :number_of_groups

  def initialize(students:, groups_of: nil, sort_type:, number_of_groups: nil)
    @students = students
    @groups_of = groups_of
    @number_of_groups = number_of_groups
    @sort_type = sort_type
  end

  def make_groups
    if groups_of_n_students?
      GroupsOfNStudents.new(students: students, groups_of: groups_of, sort_type: sort_type).make_groups
    elsif n_number_of_groups?
      NNumberOfGroups.new(students: students, number_of_groups: number_of_groups).make_groups
    end
  end

  def groups_of_n_students?
    !!groups_of
  end

  def n_number_of_groups?
    !!number_of_groups
  end

  class GroupsOfNStudents

    attr_accessor :groups_of, :sort_type, :students, :final_groups, :number_of_groups

    def initialize(students:, groups_of:, sort_type:)
      @students = students
      @groups_of = groups_of
      @sort_type = sort_type
      @final_groups = []
    end
  

    def make_groups
      if sort_by_random?
        form_random_groups
      elsif sort_by_progress?
        form_progress_based_groups
      end
      final_groups
    end

    
    def sort_by_random?
      sort_type == "random"
    end

    def sort_by_progress?
      sort_type == "progress"
    end

    def form_random_groups
      students.shuffle.each_slice(groups_of.to_i) { |students| final_groups << students }
      check_student_distribution
    end

    def form_progress_based_groups
      students.sort_by {|s| s.completed_lesson_count_for_active_track}.each_slice(groups_of.to_i) { |students| final_groups << students }
      check_student_distribution
    end

    def check_student_distribution
      if leftover_students
        final_groups.pop.each_with_index do |student, i|
          final_groups["-#{i + 1}".to_i] << student
        end
      end
    end

    def leftover_students
      students.length % groups_of.to_i <=  (groups_of.to_i - 2) || students.length % groups_of.to_i == 1
    end
  end

  class NNumberOfGroups
    attr_accessor :students, :number_of_groups, :students_per_group, :final_groups

    def initialize(students:, number_of_groups:)
      @students = students
      @number_of_groups = number_of_groups
      @final_groups = []
    end

    def make_groups
      make_initial_distribution
      adjust_distribution
      final_groups
    end

    def students_per_group
      @students_per_group = students.length / number_of_groups
    end

    def make_initial_distribution
      students.each_slice(students_per_group) do |slice|
        final_groups  << slice
      end
    end

    def adjust_distribution
      if final_groups.last.size < students_per_group && final_groups.length > number_of_groups
        final_groups.pop.each_with_index do |remaining_student, i|
          final_groups[i] << remaining_student
        end
      end
    end
  end
    


end

