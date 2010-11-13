class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])

    respond_to do |format|
      format.json  { render :json => @site }
    end
  end

  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.json  { render :json => @site, :status => :created, :location => @site }
      else
        format.json  { render :json => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.json  { head :ok }
    end
  end
end
