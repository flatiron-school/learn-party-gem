require 'spec_helper'


describe LearnTogether do
  it 'has a version number' do
    expect(LearnTogether::VERSION).not_to be nil
  end

  context "groups of n students" do 

    context "when given a collection of student objects" do 

      describe "with groups of 2" do 
        describe "random" do
          students = collection_of_student_objects
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 2, sort_type: "random")
          
          it_behaves_like "groups_of_two" do 
            let(:groups) {groups}
          end
          
          it_behaves_like "groups_of_student_objects" do 
            let(:groups) {groups}
          end
        end
     

        describe "progress" do 
          students = collection_of_student_objects
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 2, sort_type: "progress")
          
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

      describe "with groups of 3" do 
        describe "random" do
          students = collection_of_student_objects
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 3, sort_type: "random")
          
          it_behaves_like "groups_of_three" do 
            let(:groups) {groups}
          end
          
          it_behaves_like "groups_of_student_objects" do 
            let(:groups) {groups}
          end
        end
     

        describe "progress" do 
          students = collection_of_student_objects
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 3, sort_type: "progress")
          
          it_behaves_like "groups_of_three" do 
            let(:groups) {groups}
          end

          it_behaves_like "groups_of_student_objects" do 
            let(:groups) {groups}
          end

          it 'sorts students based on progress' do 
            expect(calculate_sorted_lesson_counts(groups)).to match_array(groups_of_three_sorted_lesson_counts)
          end        
        end
      end

      describe "with groups of 4" do 
        describe "random" do
          students = collection_of_student_objects
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 4, sort_type: "random")
          
          it_behaves_like "groups_of_four" do 
            let(:groups) {groups}
          end
          
          it_behaves_like "groups_of_student_objects" do 
            let(:groups) {groups}
          end
        end
     

        describe "progress" do 
          students = collection_of_student_objects
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 4, sort_type: "progress")
          
          it_behaves_like "groups_of_four" do 
            let(:groups) {groups}
          end

          it_behaves_like "groups_of_student_objects" do 
            let(:groups) {groups}
          end

          it 'sorts students based on progress' do 
            expect(calculate_sorted_lesson_counts(groups)).to match_array(groups_of_four_sorted_lesson_counts)
          end        
        end
      end
    end

    context "when given a collection of student hashes" do 

      describe "with groups of 2" do 
        describe "random" do
          students = collection_of_student_hashes
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 2, sort_type: "random")
          
          it_behaves_like "groups_of_two" do 
            let(:groups) {groups}
          end
          
          it_behaves_like "groups_of_student_hashes" do 
            let(:groups) {groups}
          end
        end
     

        describe "progress" do 
          students = collection_of_student_hashes
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 2, sort_type: "progress")
          
          it_behaves_like "groups_of_two" do 
            let(:groups) {groups}
          end

          it_behaves_like "groups_of_student_hashes" do 
            let(:groups) {groups}
          end

          it 'sorts students based on progress' do 
            expect(calculate_sorted_lesson_counts(groups)).to match_array(groups_of_two_sorted_lesson_counts)
          end        
        end
      end

      describe "with groups of 3" do 
        describe "random" do
          students = collection_of_student_hashes
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 3, sort_type: "random")
          
          it_behaves_like "groups_of_three" do 
            let(:groups) {groups}
          end
          
          it_behaves_like "groups_of_student_hashes" do 
            let(:groups) {groups}
          end
        end
     

        describe "progress" do 
          students = collection_of_student_hashes
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 3, sort_type: "progress")
          
          it_behaves_like "groups_of_three" do 
            let(:groups) {groups}
          end

          it_behaves_like "groups_of_student_hashes" do 
            let(:groups) {groups}
          end

          it 'sorts students based on progress' do 
            expect(calculate_sorted_lesson_counts(groups)).to match_array(groups_of_three_sorted_lesson_counts)
          end        
        end
      end

      describe "with groups of 4" do 
        describe "random" do
          students = collection_of_student_hashes
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 4, sort_type: "random")
          
          it_behaves_like "groups_of_four" do 
            let(:groups) {groups}
          end
          
          it_behaves_like "groups_of_student_hashes" do 
            let(:groups) {groups}
          end
        end
     

        describe "progress" do 
          students = collection_of_student_hashes
          groups = LearnTogether::GroupMaker.new.run(collection: students, groups_of: 4, sort_type: "progress")
          
          it_behaves_like "groups_of_four" do 
            let(:groups) {groups}
          end

          it_behaves_like "groups_of_student_hashes" do 
            let(:groups) {groups}
          end

          it 'sorts students based on progress' do 
            expect(calculate_sorted_lesson_counts(groups)).to match_array(groups_of_four_sorted_lesson_counts)
          end        
        end
      end
    end
  end

  context "n groups of students" do 
    let(:students) {collection_of_student_objects}
    let(:generator) {LearnTogether::GroupMaker.new}
    describe "with 2 groups" do 
      it 'splits students up into two groups' do 
        groups = generator.run(collection: students, number_of_groups: 2)
        expect(groups.size).to eq 2
        expect(groups.first.size).to eq 18
        expect(groups.last.size).to eq 17
      end
    end

    describe "with 3 groups" do 
      it 'splits students up into two groups' do 
        groups = generator.run(collection: students, number_of_groups: 3)
        expect(groups.size).to eq 3
        expect(groups.first.size).to eq 12
        expect(groups[1].size).to eq 12
        expect(groups.last.size).to eq 11
      end
    end

    describe "with 4 groups" do 
      it 'splits students up into two groups' do 
        groups = generator.run(collection: students, number_of_groups: 4)
        expect(groups.size).to eq 4
        expect(groups.first.size).to eq 9
        expect(groups[1].size).to eq 9
        expect(groups[2].size).to eq 9
        expect(groups.last.size).to eq 8
      end
    end
  end

  context "incorrect student collection" do 
    it "raises a StudentType error" do 
      students = [{name: "sophie debenedetto", email: "sophie@email.com"}]
      expect{LearnTogether::GroupMaker.new.run(collection: students, number_of_groups: 2)}.to raise_error(LearnTogether::StudentTypeError)
    end
  end

  context "incorrect arguments" do 
    let(:students) {collection_of_student_objects}
    let(:generator) {LearnTogether::GroupMaker.new}
    
    describe "when sort_type, groups_of or number_of_groups is missing" do 
      it "raises an error" do 
        expect{generator.run(collection: students, group_by: "wrong thing")}.to raise_error(LearnTogether::GroupMakerArgError)
      end
    end 

    describe "when both groups_of and number_of_groups is present" do 
      it 'raises an error' do 
        expect{generator.run(collection: students, groups_of: 2, number_of_groups: 4)}.to raise_error(LearnTogether::GroupMakerArgError)
      end
    end 

    describe "when sort_type has an invalid value" do 
      it 'raises an error' do 
        expect{generator.run(collection: students, groups_of: 2, sort_type: "pikachu")}.to raise_error(LearnTogether::GroupMakerArgError)
      end
    end
  end   

end
