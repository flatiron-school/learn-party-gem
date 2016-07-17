RSpec.shared_examples "groups_of_three" do 
  it "give a batch of 35 students groups students in to the correct number of groups of three" do 
    expect(groups.first.size).to eq 3
    expect(groups.length).to eq 12
    expect(groups.last.length).to eq 2
  end
end