RSpec.shared_examples "groups_of_student_objects" do
  it "returns student objects when given a collection of student objects" do 
    expect(groups.first.first.class).to eq TestStudent
  end
end