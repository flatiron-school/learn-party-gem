RSpec.shared_examples "groups_of_two" do
  it "give a batch of 35 students groups students in to the correct number of groups of two" do
    expect(groups.first.size).to eq 2
    expect(groups.length).to eq 17
    expect(groups.last.length).to eq 3
  end
end
