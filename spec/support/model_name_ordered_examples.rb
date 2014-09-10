shared_examples_for "name ordered" do
  
    before do
      subject.class.destroy_all
    end
    
    let!(:model1) { FactoryGirl.create(subject.class, name: "ModelB") }
    let!(:model2) { FactoryGirl.create(subject.class, name: "ModelA") }
        
    specify { expect(subject.class.all).to eq [ model2, model1 ] }

end