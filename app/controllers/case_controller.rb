class CaseController < ApplicationController
    before_action :find_case, except: %i[create index]
  
    # GET /cases
    def index
      @cases = Case.all
      render json: @cases, status: :ok
    end
  
    # GET /cases/{claimant}
    def show
      render json: @case, status: :ok
    end
  
    # POST /cases
    def create
      @case = Case.new(case_params)
      if @case.save
        render json: @case, status: :created
      else
        render json: { errors: @case.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # PUT /cases/{claimant}
    def update
      if @case.update(case_params)
        render json: @case, status: :updated
      else
        render json: { errors: @case.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # DELETE /cases/{claimant}
    def destroy
      if @case.destroy
        render json: @case, status: :deleted
      else
        render json: { errors: @case.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    private
  
    def find_case
      @case = Case.find_by_claimant!(params[:claimant])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Case not found' }, status: :not_found
    end
  
    def case_params
      params.permit(
        :claimant, :allegation, :associate, :evidence, :lawyer
      )
    end

    # POST /publish
    def publish
        published_url = call_service(case_params)
        
        if mark_as_published(published_url)
            render json: @case, status: :ok
        else
            json: { errors: 'Case not publised' }, status: :not_found
        end
    end

    private
    
    def call_service(_case:)
        PublisherService.new( 
            claimant: _case.claimant, 
            allegation: _case.allegation, 
            associate: _case.associate, 
            evidence: _case.evidence, 
            lawyer: _case.lawyer 
        ).call 
    end
  
    def mark_as_published(published_url) 
        @case.published_at = Time.zone.now 
        @case.published_url = published_url 
    end 

  end
