class SummariesController < ApplicationController
  include SummariesHelper

  def index
    @assignment = Assignment.find(params[:assignment_id])
    if @assignment.marking_scheme_type == 'rubric'
      @criteria = @assignment.rubric_criteria
    else
      @criteria = @assignment.flexible_criteria
    end
  end

  def populate
    @assignment = Assignment.find(params[:assignment_id])

    if @current_user.ta?
      render json: get_summaries_table_info(@assignment,
                                            @current_user.id)
    else
      render json: get_summaries_table_info(@assignment)
    end
  end
end
