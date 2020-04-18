class PublisherService < HttpService
    attr_reader :author, :title, :slug, :category, :body

    def initialize(claimant:, allegation:, associate:, evidence:, lawyer:)
        @claimant = claimant
        @allegation = allegation
        @associate = associate
        @evidence = evidence
        @lawyer = lawyer
    end
    
    def call
        post["published_url"]
    end
    
    private
    
    def conn
        Host.new(url: '')
    end
    
    def post
        resp = conn.post '/case/publish', payload
        if resp.success?
        JSON.parse resp.body
        else
        raise ServiceResponseError
        end
    end
    
    def payload
        {claimant: claimant, allegation: allegation, associate: associate, evidence: evidence, lawyer: lawyer}
    end
end