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

end
