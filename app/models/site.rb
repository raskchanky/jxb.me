class Site < ActiveRecord::Base
  validates_presence_of :url
  validates_length_of :url, :in => 1..2048
  validates_format_of :url, :with => /^(?i)\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))$/

  def self.find_with_url(u)
    self.where(["id = ?", u.to_i(36)]).first
  end

  # def short_url
    # "http://jxb.me/#{id.to_s(36)}"
  # end

  def to_param
    id.to_s(36)
  end
end

