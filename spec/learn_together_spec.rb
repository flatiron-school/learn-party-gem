require 'spec_helper'


describe LearnTogether do
  it 'has a version number' do
    expect(LearnTogether::VERSION).not_to be nil
  end

  context "when given a collection of student objects" do 
    describe "with groups of 2" do 
      describe "random" do
        students = collection_of_student_objects
        groups = LearnTogether::GroupMaker.run(collection: students, groups_of: 2, sort_type: "random")
        
        it_behaves_like "groups_of_two" do 
          let(:groups) {groups}
        end
        
        it_behaves_like "groups_of_student_objects" do 
          let(:groups) {groups}
        end
      end
   

      describe "progress" do 
        students = collection_of_student_objects
        groups = LearnTogether::GroupMaker.run(collection: students, groups_of: 2, sort_type: "progress")
        
        it_behaves_like "groups_of_two" do 
          let(:groups) {groups}
        end

        it_behaves_like "groups_of_student_objects" do 
          let(:groups) {groups}
        end

        it 'sorts students based on progress' do 
          expect(calculate_sorted_lesson_counts(groups)).to match_array(groups_of_two_sorted_lesson_counts)
        end        
      end
    end
  end
end

  #   context "with groups of 3" do 
  #     context "when sorted randomly"
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end

  #     context "when sorted based on progress" do 
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end
  #   end

  #   context "with groups of 4" do 
  #     context "when sorted randomly"
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end

  #     context "when sorted based on progress" do 
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end
  #   end

  #   context "with groups of 10" do 
  #     context "when sorted randomly"
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end

  #     context "when sorted based on progress" do 
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end
  #   end
  # end

  # context "when given a collection of student hashes" do 
  #   context "with groups of 2" do 
  #     context "when sorted randomly"
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end

  #     context "when sorted based on progress" do 
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end
  #   end

  #   context "with groups of 3" do 
  #     context "when sorted randomly"
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end

  #     context "when sorted based on progress" do 
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end
  #   end

  #   context "with groups of 4" do 
  #     context "when sorted randomly"
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end

  #     context "when sorted based on progress" do 
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end
  #   end

  #   context "with groups of 10" do 
  #     context "when sorted randomly"
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end

  #     context "when sorted based on progress" do 
  #       it 'does something useful' do
  #         expect(false).to eq(true)
  #       end
  #     end
  #   end
  # end
# end
