class MdPagesController < ApplicationController
  def show
    @page = MdPage.find_by_slug(params[:slug])
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    md_parser = Redcarpet::Markdown.new(renderer, extensions = {})
    @markdown_content = md_parser.render(@page.content)
  end
end
