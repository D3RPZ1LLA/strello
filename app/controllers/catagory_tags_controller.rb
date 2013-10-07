class CatagoryTagsController < ApplicationController
  def create
    @catagory_tag = CatagoryTag.new(params[:catagory_tag])
    if @catagory_tag.save
      redirect_to user_url(current_user)
    else
      redirect_to user_url(current_user)
    end
  end

  def destroy
    if @catagory_tag = CatagoryTag.find_by_id(params[:id])
      @catagory_tag.destroy
    else
      flash[:errors] = "404"
    end
    redirect_to user_url(current_user)
  end
end
