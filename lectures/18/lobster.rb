require 'zlib'

require 'rack/request'
require 'rack/response'

module Rack
  # Paste has a Pony, Rack has a Lobster!
  class Lobster
    LobsterString = Zlib::Inflate.inflate("eJx9kEEOwyAMBO99xd7MAcytUhPlJyj2
    P6jy9i4k9EQyGAnBarEXeCBqSkntNXsi/ZCvC48zGQoZKikGrFMZvgS5ZHd+aGWVuWwhVF0
    t1drVmiR42HcWNz5w3QanT+2gIvTVCiE1lm1Y0eU4JGmIIbaKwextKn8rvW+p5PIwFl8ZWJ
    I8jyiTlhTcYXkekJAzTyYN6E08A+dk8voBkAVTJQ==".delete("\n ").unpack("m*")[0])

    def call(env)
      req = Request.new(env)
      if req.GET["flip"] == "left"
        lobster = LobsterString.split("\n").
          map { |line| line.ljust(42).reverse }.
          join("\n")
        href = "?flip=right"
      elsif req.GET["flip"] == "crash"
        raise "Lobster crashed"
      else
        lobster = LobsterString
        href = "?flip=left"
      end

      res = Response.new
      res.write "<title>Lobstericious!</title>"
      res.write "<pre>"
      res.write lobster
      res.write "</pre>"
      res.write "<p><a href='#{href}'>flip!</a></p>"
      res.write "<p><a href='?flip=crash'>crash!</a></p>"
      res.finish
    end
  end
end
