shared_examples_for "all dependency owners" do

  describe "#has_dependents" do
    specify { expect(owner.has_dependents?).to eq true }
    
    context "when dependent is destroyed" do
      before { dependent.destroy }
      specify { expect(owner.has_dependents?).to eq false }
    end      
  end

  describe "#destroy" do
    specify do
      expect do
        owner.destroy
      end.to raise_error(ActiveRecord::DeleteRestrictionError)                    
    end
    
    context "when dependent is destroyed" do
      before do
        dependent.destroy
        owner.destroy
      end
      
      specify { expect(dependent.class.where(id: dependent.id)).to be_empty }
      specify { expect(owner.class.where(id: owner.id)).to be_empty }
    end
  end

end