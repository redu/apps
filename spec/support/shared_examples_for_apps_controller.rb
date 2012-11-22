# encoding: utf-8
shared_examples 'a hater of rating cheaters' do |rating_value|
  before do
    post :rate, { id: @app, rating: rating_value, locale: 'pt-BR' }
  end

  it { should respond_with(:redirect) }

  it "shouldn't create app rating for user" do
    @app.evaluators_for(:rating).should_not include @user
  end

  it "should set flash notice message" do
    flash[:error].should == "Valor de classificação inválido."
  end
end
