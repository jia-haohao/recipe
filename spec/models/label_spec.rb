require 'rails_helper'
RSpec.describe Label, type: :model do
  describe 'associations' do
    it 'has many labellings' do
      association = described_class.reflect_on_association(:labellings)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many cooks through labellings' do
      association = described_class.reflect_on_association(:cooks)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:labellings)
    end
  end

  describe 'class methods' do
    describe '.ransackable_attributes' do
      it 'returns an array of ransackable attributes' do
        ransackable_attributes = Label.ransackable_attributes
        expect(ransackable_attributes).to eq(%w(id name created_at updated_at))
      end
    end

    describe '.ransackable_associations' do
      it 'returns an array of ransackable associations' do
        ransackable_associations = Label.ransackable_associations
        expect(ransackable_associations).to eq(%w(labellings cooks))
      end
    end
  end
end

