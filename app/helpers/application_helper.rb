module ApplicationHelper

  def nav_link(*args, &block)
    text = args.first
    link = args.second
    classname = args.third || ""
    if block_given?
      link = args.first
      classname = args.second || ""
      text = capture(&block)
    end
    #is active_page doesn't like external links
    is_active = false
    begin
      is_active = is_active_page?(link)
      if is_active
        classname = "#{classname} active"
        text = content_tag(:span, "", :class => "icon-chevron-right icon-white") + " " + text
      end
    rescue
    end
    content_tag(:li, class: is_active ? 'active' : '') do
      link_to( text, link, :class => classname)
    end
  end

  def is_active_page?(link=nil)
    if link.nil?
      link = get_url_path()
    end
    recognized = Rails.application.routes.recognize_path(link)
    controller_action = is_active_controller_action?(recognized[:controller], recognized[:action])
    if (controller_action && recognized[:id])
      return recognized[:id] == params[:id]
    end
    return controller_action && params[:id].nil?
  end

  def is_active_controller_action?(controller, action)
    return params[:controller] == controller && params[:action] == action
  end

  def is_active_controller?(controller)
    return controller == params[:controller]
  end

  def active_controller()
    return params[:controller]
  end

  def are_active_controllers?(*args)
    active = false
    args.each do |url|
      if is_active_controller?(url)
        active = true
        break
      end
    end
    return active
  end

  def get_url_path()
    return request.fullpath
  end

  def current_pages?(*args)
    current = false
    args.each do |url|
      if current_page?(url)
        current = true
        break
      end
    end
    return current
  end
end
