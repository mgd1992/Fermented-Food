module ApplicationHelper
  
  def show_global_navbar?
    !current_page?(root_path)
  end

end
