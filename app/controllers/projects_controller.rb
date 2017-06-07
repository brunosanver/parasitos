class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    #@projects = Project.all.order('created_at DESC')
    if params[:search]
      @projects = Project.search(params[:search]).order("created_at DESC")
    elsif params[:category].blank? && params[:fabrication].blank?
      @projects = Project.all.order('created_at DESC')
    elsif params[:fabrication].blank?
      @category_id = Category.find_by(name: params[:category]).id
      @projects = Project.where(:category_id => @category_id).order('created_at DESC')
    elsif params[:category].blank?
      @fabrication_id = Fabrication.find_by(name: params[:fabrication]).id
      @projects = Project.where(:fabrication_id => @fabrication_id).order('created_at DESC')
    else
      @category_id = Category.find_by(name: params[:category]).id
      @fabrication_id = Fabrication.find_by(name: params[:fabrication]).id
      @projects = Project.where(:fabrication_id => @fabrication_id, :category_id => @category_id).order('created_at DESC')
    end
  end

  def show
  end

  def new
    @project = current_user.projects.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
    @fabrications = Fabrication.all.map{ |f| [f.name, f.id] }
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.category_id = params[:category_id]
    @project.fabrication_id = params[:fabrication_id]

    if @project.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
    @fabrications = Fabrication.all.map{ |f| [f.name, f.id] }
  end

  def update
    @project.category_id = params[:category_id]
    @project.fabrication_id = params[:fabrication_id]
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to root_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :direction, :description, :category_id, :fabrication_id, :avatar)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
