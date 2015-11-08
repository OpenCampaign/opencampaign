namespace :pages do
  desc "Create pages specified in ENV['MENU_PAGES']"
  task :create => :environment do
    pages = ENV['MENU_PAGES'].split(';')
    Rails.logger.debug("Pages: #{pages}")
    pages.each do |page_slug|
      page = MdPage.find_by_slug(page_slug)
      if page.blank?
        Rails.logger.debug "Creating '#{page_slug}' page..."
        page = MdPage.new(
          title: "#{page_slug.capitalize}",
          slug: page_slug,
          content: "# #{page_slug.capitalize}"
        )
        page.save if page.valid?
        Rails.logger.debug "Done"
      else
        Rails.logger.debug "Skipped '#{page_slug}' page as it already exists."
      end
    end
  end
end
