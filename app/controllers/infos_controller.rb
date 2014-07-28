require 'net/http'
require 'net/https'
require 'rexml/document'
include REXML

class InfosController < ApplicationController
  def index
    @data = d(getQuery['query'], getBingidpw.cid, getBingidpw.password)
    #@data = d(getQuery['query'], '52cb4735-5778-4c8f-9e90-ed2e05120cbd', 'FuX1qN/fBlt2YRvsNWB+Ccz+5lAEoDkA7lRU+bgQryk')
  end

  def search
  end

private
  def d(query, userId, passwd)
    C_duan.new(query, userId, passwd).get_data
  end

  def getQuery
    params.permit(:query)
  end

  def getBingidpw
    Bingidpw.first
  end
end

class C_duan
  def  initialize(query, userId, passwd)
    @uri = "/Bing/SearchWeb/v1/Web?Query=%27#{query}%27"
    @url = 'api.datamarket.azure.com'
    @userId = userId
    @passwd = passwd
  end

  def get_data
    data = {}
    start.elements.each('feed/entry/content/m:properties'){|e|
      a = {}
      a['title'] = e.elements['d:Title'].text
      a['des'] = e.elements['d:Description'].text
      a['displayurl'] = e.elements['d:DisplayUrl'].text
      a['url'] =  e.elements['d:Url'].text
      data[e.elements['d:ID'].text] = a
    }
    data
  end

  def start
    pre_start.start(){|http|
      req = http_get.new(@uri)
      req.basic_auth(@userId, @passwd)
      res = http.request(req)
      doc = Document::new(res.body)
      doc
    }
  end

  def pre_start
    http = http_client.new(@url, 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end

  def http_client
    Net::HTTP
  end

  def http_get
    Net::HTTP::Get
  end
end
