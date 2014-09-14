shared_examples_for "season unique named" do
  
  it { is_expected.to respond_to(:unique_name) }
  
  describe '#unique_name' do
    specify { expect(subject.unique_name).to eq subject.season.name }
  end
  
  describe "unique name order" do
    before do
      subject.class.destroy_all
    end
        
    let!(:season1) { FactoryGirl.create(:season, date: Date.today - 1.day) }
    let!(:season2) { FactoryGirl.create(:season, date: Date.today) }
    let!(:model1) { FactoryGirl.create(subject.class, season: season1) }
    let!(:model2) { FactoryGirl.create(subject.class, season: season2) }
            
    specify { expect(subject.class.unique_name_ordered).to eq [ model2, model1 ] }
  end
  
end