class SitesController < ApplicationController
  def show
    @site = Site.find_with_url(params[:url])

    respond_to do |format|
      if @site
        format.html { redirect_to @site.url }
        format.json { render :json => @site.url }
      else
        format.json { render :text => '', :status => :not_found }
      end
    end
  end

  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.json { render :json => short_url(@site), :status => :created }
      else
        format.json { render :json => @site.errors, :status => :unprocessable_entity }
      end
    end
  end
end
