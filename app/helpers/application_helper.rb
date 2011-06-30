# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def items_category_path cat
    case cat.class.to_s 
    when 'ProductCategory' then products_category_path(cat)
    when 'WorkCategory' then works_category_path(cat)
    end
  end
  
  def item_path item
    case item.class.to_s 
    when 'Product' then product_path(item)
    when 'Work' then work_path(item)
    end
  end

  def link_to_page page
    if page
      case page.class.to_s
      when 'HomePage' then root_path 
      when 'ProductPage' then products_path
      when 'WorkPage' then works_path
      when 'OfferPage' then offers_path
      else page_path(page)
      end
    end    
  end
  
  def category_list model, admin = false, active = nil, active_item = nil
    list = ''
    roots = model.roots
    roots.each do |root|
      list += content_tag(:ul, content_tag(:li, link_to('&nbsp;','#',:class=>'toggle'+(' active' if active == root).to_s) + link_to_if(active != root, root.name, (admin ? edit_admin_category_path(root) : items_category_path(root)), :class => ('active' if active == root)) + (link_to(" "+image_tag("icons/plus.png"), new_admin_category_path(:parent_id => root.id, :type => model), :title => "Dodaj podkategorie") if admin).to_s + content_tag(:p, root.items.map{|item| link_to_if(active_item != item, item.name, item_path(item))}.join('<br />'), :class => "small"+(" active" if root.items.include?(active_item)).to_s)+ subcategory_list(root, admin, active, active_item)), :class => 'root')
    end
    list += link_to("Dodaj kategorie glowna", new_admin_category_path(:type => model)) if admin
    list
  end
  
  def subcategory_list root, admin, active, active_item
    list = ''
    root.children.each do |cat|
      list += content_tag(:li, link_to('&nbsp;','#',:class=>'toggle'+(' active' if active == cat).to_s) + link_to_if(active != cat, cat.name, (admin ? edit_admin_category_path(cat) : items_category_path(cat)), :class => ('active' if active == cat)) + (link_to(" "+image_tag("icons/plus.png"), new_admin_category_path(:parent_id => cat.id, :type => cat.class), :title => "Dodaj podkategorie") if admin).to_s + content_tag(:p, cat.items.map{|item| link_to_if(active_item != item, item.name, item_path(item))}.join('<br />'), :class => "small"+(" active" if cat.items.include?(active_item)).to_s) + subcategory_list(cat, admin, active, active_item))
    end  
    #	  list += content_tag(:li, link_to("Nowa", new_admin_category_path)) if admin
    list.present? ? content_tag(:ul, list) : ''
  end

  def items_category_name model
    case model.to_s
    when 'ProductCategory' then "product[category_ids][]"
    when 'FeatureCategory' then "feature[category_ids][]"
    end
  end

  def checkbox_category_list model, obj
    list = ''
    roots = model.roots
    roots.each do |root|
      list += content_tag(:ul, content_tag(:li, check_box_tag(items_category_name(model), root.id, obj.categories.include?(root)) + root.name + checkbox_subcategory_list(root, obj)))
    end
    list
  end
  
  def checkbox_subcategory_list root, obj
    list = ''
    root.children.each do |cat|
      list += content_tag(:li, check_box_tag(items_category_name(root.class), cat.id, obj.categories.include?(cat)) + cat.name + checkbox_subcategory_list(cat, obj))
    end  
    #	  list += content_tag(:li, link_to("Nowa", new_admin_category_path)) if admin
    list.present? ? content_tag(:ul, list, :style => 'margin:0;') : ''
  end

  def is_active? controller, page
    if controller.controller_name == 'pages' && params[:id].nil? && page.is_a?(HomePage)
      return 'active'
    elsif controller.controller_name == 'products' && page.is_a?(ProductPage)
      return 'active'
    elsif controller.controller_name == 'works' && page.is_a?(WorkPage)
      return 'active'
    elsif controller.controller_name == 'offers' && page.is_a?(OfferPage)
      return 'active'
    elsif page.permalink == params[:id] || page.children.any?{|c| c.permalink == params[:id]}
      return 'active'
    end
  end
end
