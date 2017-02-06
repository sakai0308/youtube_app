class SearchesController < ApplicationController
  require 'open-uri'
  require 'json'

  DEVELOPER_KEY = 'AIzaSyDeLSrLhx_8dBSsFPZ9X0gg-G0JDSbITuk'

  def index
  end

  # 参考サイト
  # http://crossfabricate.hatenablog.com/entry/2016/03/28/194203
  def search
    #検索キーワードを取得
    @search_data = params.require(:search_data).permit(:keyword)
    @keyword = @search_data["keyword"]

    #検索処理
    url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=" + @keyword + "&key=" + DEVELOPER_KEY + "&maxResults=10"
    res = open(url)
    result = res.read
    search_response = JSON.parse(result)
    
    #検索結果
    @search_result = ""
    
    search_response["items"].each do |search_result|
      @search_result += "<tr>"
      @search_result += "<td>" + search_result["id"]["kind"].to_s + "</td>"
      @search_result += "<td>" + search_result["snippet"]["title"].to_s + "</td>"
      @search_result += "<td>" + search_result["id"]["videoId"].to_s + "</td>"
      @search_result += "</tr>"
    end

  end

end
