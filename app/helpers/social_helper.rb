module SocialHelper
  def render_stream(type, payload)
    response = "".html_safe
    case type
    when 'twitter'
      response << "<a class=\"twitter-timeline\" href=\"https://twitter.com/".html_safe
      response << payload['username']
      response << "\" data-widget-id=\"".html_safe
      response << payload['widgetid']
      response << "\">Tweets by @".html_safe
      response << payload['username']
      response << "</a>".html_safe
    when 'facebook-page'
      response << "<div class=\"fb-page\" data-href=\"https://www.facebook.com/".html_safe
      response << payload['pagename']
      response << "\" data-small-header=\"true\" data-adapt-container-width=\"true\" data-hide-cover=\"false\" data-show-facepile=\"true\" data-show-posts=\"true\"><div class=\"fb-xfbml-parse-ignore\"><blockquote cite=\"https://www.facebook.com/".html_safe
      response << payload['pagename']
      response << "\"><a href=\"https://www.facebook.com/".html_safe
      response << payload['pagename']
      response << "\">Facebook</a></blockquote></div></div>".html_safe
    when 'pinterest-square'
      response << "<a data-pin-board-width=\"400\" data-pin-do=\"embedUser\" data-pin-scale-height=\"240\" data-pin-scale-width=\"80\" href=\"https://www.pinterest.com/".html_safe
      response << payload['username']
      response << "\"></a>".html_safe
    end
    response
  end
end
