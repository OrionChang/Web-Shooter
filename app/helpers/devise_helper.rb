module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    

    html = <<-HTML

      <div class="alert alert-danger alert-block">
        <button type="button" class="close" data-dismiss="alert">x</button>
            #{messages}
      </div>
    HTML


    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end


  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


end