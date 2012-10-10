require 'spec_helper'

describe Comment do
  # Usuário que criou o comentário
  it { should respond_to(:author) }
  it { should belong_to(:author) }
  it { should validate_presence_of(:author) }

  # Aplicativo que recebeu o comentário
  it { should respond_to(:app) }
  it { should belong_to(:app) }
  it { should validate_presence_of(:app) }

  # Texto do comentário
  it { should respond_to(:body) }
  it { should validate_presence_of(:body) }
  it { should ensure_length_of(:body).is_at_least(1)}

  # Scopes
  context 'when searching for' do
    before do
      @specialist = FactoryGirl.create(:specialist)
      @member = FactoryGirl.create(:member)
      5.times do |n|
        if n.odd?
          FactoryGirl.create(:comment, :author => @specialist)
        else
          FactoryGirl.create(:comment, :author => @member)
        end
      end
    end

    # Recupera comentários de usuários especialistas
    context 'specialized ones' do
      before { @comments = Comment.specialized }
      it 'should return comments which author is an specialist' do
        @specialist.comments.each do |comment|
          @comments.should include comment
        end
      end

      it 'should not return comments which author is a member' do
        @member.comments.each do |comment|
          @comments.should_not include comment
        end
      end
    end

    # Recupera comentários de usuários membros
    context 'common ones' do
      before { @comments = Comment.common }
      it 'should return comments which author is a member' do
        @member.comments.each do |comment|
          @comments.should include comment
        end
      end

      it 'should not return comments which author is a specialist' do
        @specialist.comments.each do |comment|
          @comments.should_not include comment
        end
      end
    end
  end
end
