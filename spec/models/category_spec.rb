# encoding: utf-8
require 'spec_helper'

describe Category do
  it { should respond_to(:name) }
  it { should respond_to(:kind) }
  it { should have_many(:app_category_associations).dependent(:destroy) }
  it { should have_many(:apps).through(:app_category_associations)}

  describe 'Class methods' do
    before do
      @app1 = FactoryGirl.create :app
      @app2 = FactoryGirl.create :app
      @apps = [@app1, @app2]
      @app1.categories << Category.create(name: "Fundamental", kind: "Nível")
      @app2.categories << Category.create(name: "Médio", kind: "Nível")
      @app1.categories << Category.create(name: "Exatas", kind: "Área")
      @app1.categories << Category.create(name: "Da Natureza", kind: "Área")
      @app2.categories << Category.create(name: "Humanas", kind: "Área")
      @app2.categories << Category.create(name: "Geogafia", kind: "Subárea")
    end

    describe :filters_on do
      let(:ret) { Category.filters_on @apps }

      it 'returns only categories which are filters' do
        ret.each do |cat|
          cat.kind.should == "Nível"
        end
      end

      it 'returns all categories which (belong to passed apps and) are filters' do
        ret.length.should == @apps.collect(&:categories).flatten.
          select { |c| c.kind == "Nível" }.length
      end
    end # describe :filters_on

    describe :count_filters_on do
      let(:ret) { Category.count_filters_on (@app1.categories + @app2.categories) }

      it 'returns a hash' do
        ret.class == 'Hash'
      end

      it 'counts categories in the array and puts the count value into the hash' do
        (@app1.categories + @app2.categories).each do |cat|
          ret[cat.name].should == 1
        end
      end
    end # describe :count_filters_on

    describe :get_by_kind do
      let(:ret) { Category.get_by_kind @app1, "Área" }

      it 'returns the two categories which are labeled with Área kind' do
        @app1.categories.select { |c| c.kind == 'Área'}.each do |cat|
          ret.should include cat
        end
      end
    end # describe :get_by_kind

    describe :get_names_by_kind do
      let(:ret) { Category.get_names_by_kind @app1 }

      it 'returns a hash' do
        ret.class == 'Hash'
      end

      it 'returns a hash with same number of keys as number of category kinds' do
        ret.keys.length.should == @app1.categories.collect(&:kind).uniq.count
      end

      it 'assigns Nível kind into hash properly' do
        ret['Nível'].should == @app1.categories.select { |c| c.kind == 'Nível' }.
          collect(&:name)
      end

      it 'assigns Área kind into hash properly' do
        ret['Área'].should == @app1.categories.select { |c| c.kind == 'Área' }.
          collect(&:name)
      end
    end # describe :get_names_by_kind
  end # describe 'Class methods'

  describe 'Ordering' do
    before do
      @level = Category.create(name: 'One', kind: 'Nível')
      @sublevel = Category.create(name: 'One', kind: 'Subnível')
      @area = Category.create(name: 'One', kind: 'Área')
      @subarea = Category.create(name: 'One', kind: 'Subárea')
    end

    it 'sorts Nível kind prior to Subnível' do
      (@level <=> @sublevel).should == -1
    end

    it 'sorts Subnível kind prior to Área' do
      (@sublevel <=> @area).should == -1
    end

    it 'sorts Área kind prior to Subárea' do
      (@area <=> @subarea).should == -1
    end

    context 'when sorting an array of categories' do
      before do
        @categories = [@area, @subarea, @level, @sublevel]
      end

      it 'sorts categories properly' do
        @categories.sort.should == [@level, @sublevel, @area, @subarea]
      end
    end
  end
end
