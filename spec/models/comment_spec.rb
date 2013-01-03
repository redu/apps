require 'spec_helper'

describe Comment do
  # Usuário que criou o comentário
  it { should respond_to(:author) }
  it { should belong_to(:author) }
  it { should validate_presence_of(:author) }

  # Tipo do comentário
  it { FactoryGirl.create(:common_comment).type.should == :common }
  it { FactoryGirl.create(:specialized_comment).type.should == :specialized }

  # Aplicativo que recebeu o comentário
  it { should respond_to(:app) }
  it { should belong_to(:app) }
  it { should validate_presence_of(:app) }

  # Texto do comentário
  it { should respond_to(:body) }
  it { should validate_presence_of(:body) }
  it { should ensure_length_of(:body).is_at_least(2)}

  # Respostas
  it { should have_many(:answers).dependent(:destroy) }

  # No caso de respostas, comentário respondido
  it { should respond_to(:in_response_to) }

  # Scopes
  context 'when searching for' do
    before do
      @specialist = FactoryGirl.create(:specialist)
      @member = FactoryGirl.create(:member)
      @specialized = Array.new
      @common = Array.new
      5.times do
        n = rand(3)
        case n
        when 0 # Comentário especializado criado por especialista
          @specialized << FactoryGirl.create(:specialized_comment, author: @specialist)
        when 1 # Comentário comum criado por especialista
          @common << FactoryGirl.create(:common_comment, author: @specialist)
        when 2 # Comentário comum criado por membro
          @common << FactoryGirl.create(:common_comment, author: @member)
        end
      end
    end

    # Recupera comentários do tipo specialized
    context 'specialized ones' do
      before { @comments = Comment.specialized }
      it 'should return same number as specialized comments' do
        @comments.count.should == @specialized.count
      end

      it 'should not return comments which author is a member' do
        @member.comments.each do |comment|
          @comments.should_not include comment
        end
      end
    end # context 'specialized ones'

    # Recupera comentários do tipo common
    context 'common ones' do
      before { @comments = Comment.common }
      it 'should return comments which author is a member' do
        @member.comments.each do |comment|
          @comments.should include comment
        end
      end

      it 'should return same number as common comments' do
        @comments.count.should == @common.count
      end

      it 'should return comments which author is a specialist if it is common' do
        @specialist.comments.each do |comment|
          @comments.should include comment if comment.type == :common
        end
      end
    end # context 'common ones'
  end # context 'when searching for'
end
