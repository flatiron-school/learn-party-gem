require 'spec_helper'

describe LearnTogether do
  it 'has a version number' do
    expect(LearnTogether::VERSION).not_to be nil
  end

  context "when given a collection of student objects" do 
    let!(:students) { collection_of_student_objects }
    context "with groups of 2" do 
      context "when sorted randomly" do
        it 'generates the correct number of groups of 2' do
          groups = LearnTogether::GroupMaker.run(collection: students, groups_of: 2, sort_type: "random")
          expect(groups.first.size).to eq 2
          expect(groups.length).to eq 17
          expect(groups.last.length).to eq 3
        end
      end
    end
  end
end

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
