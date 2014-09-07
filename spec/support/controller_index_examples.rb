shared_examples_for "index controller" do

  describe "GET 'index'" do
    specify do
      get 'index'
      expect(response).to be_success
    end
  end

end