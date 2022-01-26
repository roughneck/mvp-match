require 'rails_helper'

describe ChangeService do
  subject { described_class.new(deposit).call }

  context 'when deposit is 30' do
    let(:deposit) { 30 }
    let(:expected_result) {
      { 5 => 0, 10 => 1, 20 => 1, 50 => 0, 100 => 0 }
    }

    it 'returns correct change for 30' do
      expect(subject).to eq(expected_result)
    end
  end

  context 'when deposit is 60' do
    let(:deposit) { 60 }
    let(:expected_result) {
      { 5 => 0, 10 => 1, 20 => 0, 50 => 1, 100 => 0 }
    }

    it 'returns correct change for 60' do
      expect(subject).to eq(expected_result)
    end
  end

  context 'when deposit is 110' do
    let(:deposit) { 110 }
    let(:expected_result) {
      { 5 => 0, 10 => 1, 20 => 0, 50 => 0, 100 => 1 }
    }

    it 'returns correct change for 110' do
      expect(subject).to eq(expected_result)
    end
  end

  context 'when deposit is 195' do
    let(:deposit) { 195 }
    let(:expected_result) {
      { 5 => 1, 10 => 0, 20 => 2, 50 => 1, 100 => 1 }
    }

    it 'returns correct change for 190' do
      expect(subject).to eq(expected_result)
    end
  end

  context 'when deposit is 200' do
    let(:deposit) { 200 }
    let(:expected_result) {
      { 5 => 0, 10 => 0, 20 => 0, 50 => 0, 100 => 2 }
    }

    it 'returns correct change for 200' do
      expect(subject).to eq(expected_result)
    end
  end
end
