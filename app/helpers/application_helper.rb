module ApplicationHelper
  # Helper for converting Boolean true/false values to Yes or No - see config/locales/en.yml
  def humanize_boolean(boolean)
    I18n.t((!!boolean).to_s)
  end
end
