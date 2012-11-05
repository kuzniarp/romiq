module ProductsHelper

  def get_items_view
    @current_view || 'long_view'
  end

  def get_items_order
    @current_order || 'date'
  end
end
