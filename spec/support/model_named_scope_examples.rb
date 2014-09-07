shared_examples_for "named scope" do
  
  before do
    subject.class.destroy_all
  end

  let!(:model1) { FactoryGirl.create(subject.class, name: "ModelB") }
  let!(:model2) { FactoryGirl.create(subject.class, name: "ModelA") }
  
  context "with valid search term" do
    let(:found_models) { subject.class.named(model1.name) }
    
    specify { expect(found_models).to eq [ model1 ] }      
  end

  context "with partially valid search terms" do
    let(:found_models) { subject.class.named("#{model1.name[0,3]} #{model1.name[-3,3]}") }

    specify { expect(found_models).to eq [ model1 ] }            
  end

  context "with multiple matches" do
    let(:found_models) { subject.class.named("#{model1.name[0,3]}") }
    
    specify { expect(found_models.sort).to eq [ model1, model2].sort }      
  end

  context "with invalid search term" do
    let(:found_models) { subject.class.named("#{model1.name} foo") }
    
    specify { expect(found_models).to be_empty }      
  end
  
  context "with empty search term" do
    let(:found_models) { subject.class.named("") }
    
    specify { expect(found_models).to be_empty }
  end

end