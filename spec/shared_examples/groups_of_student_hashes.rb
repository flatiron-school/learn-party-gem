RSpec.shared_examples "groups_of_student_hashes" do
  it "returns student objects when given a collection of student objects" do 
    expect(groups.first.first.class).to eq OpenStruct
    expect(groups.first.first).to respond_to(:[])
  end
end