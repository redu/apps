shared_examples 'a checkout variables ascriber' do
  it 'assigns space_id variable' do
    assigns(:space_id).to_i.should == @space.id
  end

  it 'assigns create_subject variable' do
    assigns(:create_subject).should_not be_nil
  end

  it 'assigns subject variable' do
    assigns(:subject).should_not be_nil
  end

  it 'assigns lecture variable' do
    assigns(:lecture).should_not be_nil
  end
end
