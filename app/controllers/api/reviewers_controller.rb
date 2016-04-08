class Api::ReviewersController < Api::BaseController
  def show
    @pr = PullRequest.find_by(repository: params[:repo], number: params[:pull_id])
    if @pr.present?
      render json: params[:status] == "completed" ? @pr.completed_reviews : @pr.pending_reviews
    else
      head :not_found
    end
  end

  def add_reviewer
    @pr = PullRequest.find_by(repository: params[:repo], number: params[:pull_id])
    if @pr.present?
      reviewers_to_add = JSON.load(request.body.read)
      @pr.pending_reviews += reviewers_to_add
      if @pr.save
        render json: @pr.pending_reviews
      else
        head :unprocessable_entity
      end
    else
      head :not_found
    end
  end
end
