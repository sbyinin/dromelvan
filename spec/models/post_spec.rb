require 'rails_helper'

describe Post, type: :model do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:title) { "Test Title" }
  let(:content) { "Test content." }
  
  before { @post = FactoryGirl.create(:post, user: admin, title: title, content: content) }
  
  subject { @post }
 
  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:content) }
  
  it { is_expected.to be_valid }
  
  describe '#user' do
    specify { expect(@post.user).to eq admin } 
  end 

  describe '#title' do
    specify { expect(@post.title).to eq title } 
  end 
  
  describe '#content' do
    specify { expect(@post.content).to eq content } 
  end 
  
  context "when user is nil" do
    before { @post.user = nil }
    it { is_expected.not_to be_valid }
  end

  context "when title is nil" do
    before { @post.title = nil }
    it { is_expected.not_to be_valid }
  end

  context "when title is invalid" do
    before { @post.title = "" }
    it { is_expected.not_to be_valid }
  end
  
  context "when content is nil" do
    before { @post.content = nil }
    it { is_expected.not_to be_valid }
  end

  context "when content is invalid" do
    before { @post.content = "" }
    it { is_expected.not_to be_valid }
  end
  
  describe "default scope order" do
    before { Post.destroy_all }
    
    let!(:post1) { FactoryGirl.create(:post) }
    let!(:post2) { FactoryGirl.create(:post) }
    let!(:post3) { FactoryGirl.create(:post) }
   
    specify { expect(Post.all).to eq [ post3, post2, post1 ] }
  end   
end
