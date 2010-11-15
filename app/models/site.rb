class Site < ActiveRecord::Base
  validates_presence_of :url
  validates_length_of :url, :in => 1..2048
  validates_format_of :url, :with => /^(?i)\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))$/
  before_create :make_the_urls

  CHARS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

  def self.find_with_url(u)
    self.where(["short_url = ? OR long_url like ?", u, u]).first
  end

  def to_param
    short_url
  end

  private
  def make_the_urls
    t = Time.zone.now
    num = t.to_i + t.usec
    self.key = num
    self.short_url = encode(num)
    self.long_url = generate_long_url
  end

  def generate_long_url
    u = URI.parse(url)
    result = []
    u.host.chars { |c| result << encode(c.ord, '01') }
    result.join
  end

  def encode(num, alphabet=CHARS)
    return alphabet[0] if num == 0
    result = []
    base = alphabet.size
    while num > 0
      rem = num % base
      num /= base
      result << alphabet[rem].chr
    end
    result.reverse.join
  end

  # unused right now, but wtf.  might as well have it
  def decode(str, alphabet=CHARS)
    base = alphabet.size
    l = str.size
    num, i = 0, 0

    str.chars do |c|
      power = l - (i + 1)
      num += (alphabet.index(c) * (base ** power))
      i += 1
    end
    num
  end
end

