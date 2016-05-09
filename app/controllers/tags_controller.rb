class TagsController < ApplicationController

  def index
    @tags = Tag.all
    render json: @tags
  end

  def index_relations
    @tags = TagRelation.all
    render json: @tags
  end

  def index_from_user
    @tags = User.find(params[:id]).tags
    render json: @tags
  end

  def add_tag
  	potential_relation = TagRelation.find_by_user_id_and_tag_id(params[:user_id], params[:tag_id])
  	if !(potential_relation.blank?)
  		potential_relation.delete
  	else
  		TagRelation.create(user_id: params[:user_id], tag_id: params[:tag_id])
  	end
  end

  def index_relations_from_user
  	puts (params[:id])
  	@tag_relations = User.find(params[:id]).tag_relations
    render json: @tag_relations
  end


end
