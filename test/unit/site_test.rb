require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  test "url is required" do
    s = Site.new
    assert_equal false, s.valid?
    assert s.errors[:url]
    assert s.errors[:url].any? { |x| x =~ /can't be blank/ }
  end

  test "url must be the proper size" do
    s = Site.new
    s.url = "http://google.com"
    assert s.valid?
    s.url = "http://" + ("o" * 2049) + ".com"
    assert_equal false, s.valid?
    assert s.errors[:url]
    assert s.errors[:url].any? { |x| x =~ /is too long/ }
  end

  test "url must be valid" do
    s = Site.new
    s.url = "http://google.com"
    assert s.valid?

    t = Site.new
    t.url = "whatever"
    assert_equal false, t.valid?
    assert t.errors[:url]
    assert t.errors[:url].any? { |x| x =~ /is invalid/ }
  end

  test "short and long urls should be generated when the site is saved" do
    s = Site.create :url => 'http://google.com'
    assert s.short_url
    assert s.long_url
  end

  # yes, i know you're not supposed to test private methods, but this is 
  # the crux of the whole site
  test "encoding" do
    s = Site.new
    hex = '0123456789ABCDEF'
    assert_equal '4F', s.send(:encode, 79, hex)

    bin = '01'
    assert_equal '101', s.send(:encode, 5, bin)
  end

  test "decoding" do
    s = Site.new
    hex = '0123456789ABCDEF'
    assert_equal 79, s.send(:decode, '4F', hex)

    bin = '01'
    assert_equal 5, s.send(:decode, '101', bin)
  end
end
