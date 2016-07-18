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
      students.length % groups_of <=  (groups_of - 2) || students.length % groups_of == 1
    end
  end

  class NNumberOfGroups
    attr_accessor :students, :number_groups, :students_per_group

    def initialize(students:, number_groups:)
      @students = students
      @number_groups = number_groups
    end

    def make_groups
      @final_groups = []
      make_initial_distribution
      if @final_groups.last < students_per_group
        #[student 12, student13]
        @final_groups.pop.each_with_index do |remaining_student, i|
          @final_groups[i] << remaining_student
        end
      end
      @final_groups
    end

    def students_per_group
      @students_per_group = students.length / number_of_groups
      # 35 / 3 = 11
      # remainder 35 % 3 = 2
    end

    def make_initial_distribution
      students.each_slice(students_per_group) do |slice|
        @final_groups  << slice
      end
    end
  end
    


end

# require_relative "./table.rb"

# class PairMaker

#   attr_accessor :batches

#   def initialize
#     @batches = []
#   end

#   def make_pairs_random(students)
#     students.shuffle!
#     two_from_batch(students)
#     make_tables
#   end

#   def make_pairs_mindful(students)
#     sorted = sort_by_progress(students)
#     two_from_batch(sorted)
#     two_groups_of_two = []
#     self.batches.each_slice(2) {|slice| two_groups_of_two << slice}
#     mindful_batch_of_two(two_groups_of_two)
#   end

#   def make_pairs_progress(students)
#     sorted_students = sort_by_progress(students)
#     two_from_batch(sorted_students)
#     make_tables
#   end

#   def make_tables_progress(students)
#     sorted_students = sort_by_progress(students)
#     four_from_batch(sorted_students)
#     make_tables
#   end

#   def make_tables_random(students)
#     students.shuffle!
#     four_from_batch(students)
#     make_tables
#   end

#   def make_tables_mindful(students)
#     sorted_students = sort_by_progress(students)
#     four_from_batch(sorted_students)
#     two_groups_of_four = []
#     self.batches.each_slice(2) {|slice| two_groups_of_four << slice}
#     mindful_batch_of_four(two_groups_of_four)
#   end

#   def make_groups(num_of_groups, students)
#     num_of_groups = students.length/num_of_groups.to_i
#     students.shuffle.each_slice(num_of_groups).each do |slice|
#       if slice.length == 1
#         Table.all.last.students << slice.first
#       else
#         Table.new(slice)
#       end
#     end
#   end

#   private

#     def randomize_students(students)
#       students.collect {|student| student.name}.shuffle!
#     end

#     def sort_by_progress(students)
#       students.sort_by! do |student| 
#         student.progress.to_i
#       end
#     end

#     def four_from_batch(students)
#       students.each_slice(4) {|slice| self.batches << slice}
#       self.batches
#     end

#     def two_from_batch(students)
#       students.each_slice(2) {|slice| self.batches << slice}
#       self.batches
#     end

#     def make_tables
#       self.batches.each do |batch|
#         Table.new(batch)
#       end
#     end

#     def mindful_batch_of_four(students)
#       students.each do |group|
#         first = group[0]
#         second = group[1]
#         if second 
#           last_two_first = first.values_at(-1, -2)
#           first_two_second = second.values_at(0, 1)
#           2.times do 
#             first.delete_at(-1)
#             second.delete_at(0)
#           end
#           first = first + first_two_second
#           second = second + last_two_first
#           Table.new(first)
#           Table.new(second)
#         else
#           Table.new(first)
#         end
#       end
#     end

#     def mindful_batch_of_two(two_groups_of_two)
#       two_groups_of_two.each do |group|
#         if group.length >= 2
#           first = group[0]
#           second = group[1]
#           first_last = first[-1]
#           second_first = second[0]
#           first.delete_at(-1)
#           second.delete_at(0)
#           first << second_first
#           second << first_last
#           Table.new(first)
#           Table.new(second)
#         else
#           Table.new(group[0])
#         end
#       end
#     end

# end
