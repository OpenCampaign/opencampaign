module ApplicationHelper

  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    notice:  'alert-info',
    alert:   'alert-block alert-warning',
    error:   'alert-error alert-danger'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym, flash_type.to_s)
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def menu_page_slugs
    ENV['MENU_PAGES'].split(';')[0..2]
  end

  def social_item(social)
    response = "".html_safe
    case social['name']
    when 'twitter'
      response << "<div class=\"panel panel-default\"><div class=\"panel-body\">".html_safe
      response << link_to("Edit #{social[:payload]['username']}'s Twitter Integration", edit_admin_social_path(social[:id]), {class: 'btn btn-primary'})
      response << "<h4>Attributes</h4><dl class=\"dl-horizontal\">".html_safe
      response << "<dt>Username</dt><dd>".html_safe
      response << social[:payload]['username']
      response << "</dd><dd>".html_safe
      response << "<dt>Widget id</dt><dd>".html_safe
      response << social[:payload]['widgetid']
      response << "</dd></dl></div></div>".html_safe
    when 'facebook-page'
      response << "<div class=\"panel panel-default\"><div class=\"panel-body\">".html_safe
      response << link_to("Edit #{social[:payload]['pagename']}'s Facebook Integration", edit_admin_social_path(social[:id]), {class: 'btn btn-primary'})
      response << "<h4>Attributes</h4><dl class=\"dl-horizontal\"><dt>Page name</dt><dd>".html_safe
      response << social[:payload]['pagename']
      response << "</dt></dl></div></div>".html_safe
    when 'pinterest-square'
      response << "<div class=\"panel panel-default\"><div class=\"panel-body\">".html_safe
      response << link_to("Edit #{social[:payload]['username']}'s Pinterest Integration", edit_admin_social_path(social[:id]), {class: 'btn btn-primary'})
      response << "<h4>Attributes</h4><dl class=\"dl-horizontal\"><dt>Username</dt><dd>".html_safe
      response << social[:payload]['username']
      response << "</dt></dl></div></div>".html_safe
    end
    response

  end
end
