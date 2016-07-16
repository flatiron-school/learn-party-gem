class Generator
  attr_accessor :groups_of, :sort_type, :students

  def initialize(students:, groups_of:, sort_type:)
    @students = students
    @groups_of= groups_of
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
    students.sort_by {|s| s.completed_lesson_for_active_track_count}.each_slice(groups_of.to_i) { |students| final_groups << students }
    check_student_distribution
  end

  def check_student_distribution
    if final_groups.last.length == 1
      final_groups[-2] << final_groups.pop.first
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
