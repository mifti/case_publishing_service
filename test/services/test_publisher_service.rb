require "rails_helper"
RSpec.describe Publisher, type: :model do
  let(:case) { 
    OpenStruct.new({ 
        claimant: '******', 
        allegation: '******', 
        associate: '******', 
        evidence: '******', 
        lawyer: '******' 
    }) 
  }
  class TestPublisherService < PublisherService 
    def call 
      "https://www.test.com/yjbcase/yjb/#{claimant}" 
    end 
  end
  describe 'publishes a case to the website' do 
    subject { Publisher.new(_case, TestPublisherService) }
    it 'sets published url' do
      published_case = subject.publish
      expect(published_case.published_url).to eq('https://www.test.com/yjbcase/yjb/victor')
    end
    
    it 'sets published at' do
      published_case = subject.publish
      expect(published_case.published_at).to be_a(Time)
    end
  end 
end