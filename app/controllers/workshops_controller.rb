class WorkshopsController < ApplicationController
  include ApplicationHelper
  before_action :set_workshop, only: [:show, :train, :make_expert, :retrain_all, :check_officer]

  def index
    if params[:member_id]
      @workshops = Member.find_by(id: params[:member_id]).workshops
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @workshops }
      end
    else
      @workshops = Workshop.all
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @workshops }
      end
    end
  end

  def show
      render json: @workshop
  end

  def retrain_all
    if current_member == @workshop.officer
      @workshop.retrain_all
      render json: @workshop
    end
  end

  def train
    member = Member.find_by(id: params[:member_id])
    @workshop.train_fully(member)
    render json: member
  end

  def check_officer
    if current_member == @workshop.officer
      render json: {'status': 'officer'}
    elsif is_admin? == true
      render json: {'status': 'admin'}
    else
      render json: {'status': 'declined'}
    end
  end

  def make_expert
    member = Member.find_by(id: params[:member_id])
    @workshop.make_expert(member)
    render json: member
  end

  private
  def set_workshop
    @workshop = Workshop.find(params[:id])
  end
end
