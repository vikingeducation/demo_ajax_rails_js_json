module PostsHelper

  def flash_message( type, value )
    "<div>#{type.capitalize}: #{value}</div>".html_safe
  end

end
