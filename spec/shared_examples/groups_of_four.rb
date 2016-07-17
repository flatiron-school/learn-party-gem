RSpec.shared_examples "groups_of_four" do 
  it "give a batch of 35 students groups students in to the correct number of groups of four" do 
    expect(groups.first.size).to eq 4
    expect(groups.length).to eq 9
    expect(groups.last.length).to eq 3
  end
end