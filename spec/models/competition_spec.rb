require 'rails_helper'

describe Competition, type: :model do
  # TODO: Add validations to ensure only 1 competition per time period
  describe 'validations' do
    it { should validate_presence_of(:code_name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects).inverse_of(:competition) }
    it { is_expected.to have_many(:transactions).inverse_of(:competition) }
  end

  describe '.current_competition' do
    context 'there is a current competition' do
      it 'returns the current competition' do
        create :previous_competition
        create :future_competition
        current_competition = create :current_competition

        expect(Competition.current_competition).to eq(current_competition)
      end
    end

    context 'there is no current competition' do
      it 'returns nil' do
        expect(Competition.current_competition).to be_nil
      end
    end
  end
end
