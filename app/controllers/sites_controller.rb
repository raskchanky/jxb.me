class SitesController < ApplicationController
  def go
    @site = Site.find_with_url(params[:url])

    if @site
      redirect_to @site.url
    else
      respond_to do |format|
        format.html { render :action => 'not_found' }
      end
    end
  end

  def not_found
    respond_to do |format|
      format.html
      format.json { render :text => 'URL not found', :status => 404 }
    end
  end

  def show
    @site = Site.find_with_url(params[:id])

    respond_to do |format|
      if @site
        format.html
        format.json { render :json => @site, :only => [:url, :short_url, :long_url] }
      else
        format.json { render :action => 'not_found' }
      end
    end
  end

  def new
    @site = Site.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site }
        format.json { render :json => {:short_url => shortened_url(@site.short_url), :long_url => lengthened_url(@site.long_url)}, :status => :created }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @site.errors, :status => :unprocessable_entity }
      end
    end
  end
end
