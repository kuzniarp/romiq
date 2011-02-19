module Admin::ProductsHelper
  def setup_option(option)
    returning(option) do |o|
      o.build_texture if o.texture.blank?
    end
  end
end
