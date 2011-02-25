# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
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
      else page_path(page)
      end
    end    
  end
  
  def category_list model, admin = false, active = nil, active_item = nil
    list = ''
    roots = model.roots
    roots.each do |root|
      list += content_tag(:ul, content_tag(:li, link_to_if(active != root, root.name, (admin ? edit_admin_category_path(root) : (model == ProductCategory ? products_category_path(root) : works_category_path(root))), :class => ('active' if active == root)) + (link_to(" "+image_tag("icons/plus.png"), new_admin_category_path(:parent_id => root.id, :type => model), :title => "Dodaj podkategorie") if admin).to_s + content_tag(:p, root.items.map{|item| link_to_if(active_item != item, item.name, item_path(item))}.join(', '), :class => "small")+ subcategory_list(root, admin, active, active_item)), :class => 'root')
    end
    list += link_to("Dodaj kategorie glowna", new_admin_category_path(:type => model)) if admin
    list
  end
  
  def subcategory_list root, admin, active, active_item
    list = ''
    root.children.each do |cat|
      list += content_tag(:li, link_to_if(active != cat, cat.name, (admin ? edit_admin_category_path(cat) : (cat.class == ProductCategory ? products_category_path(cat) : works_category_path(cat))), :class => ('active' if active == cat)) + (link_to(" "+image_tag("icons/plus.png"), new_admin_category_path(:parent_id => cat.id, :type => cat.class), :title => "Dodaj podkategorie") if admin).to_s + content_tag(:p, cat.items.map{|item| link_to_if(active_item != item, item.name, product_path(item))}.join(', '), :class => "small") + subcategory_list(cat, admin, active, active_item))
    end  
    #	  list += content_tag(:li, link_to("Nowa", new_admin_category_path)) if admin
    list.present? ? content_tag(:ul, list, :style => 'margin:0;') : ''
  end

  def checkbox_category_list model, obj
    list = ''
    roots = model.roots
    roots.each do |root|
      list += content_tag(:ul, content_tag(:li, check_box_tag("product[category_ids][]", root.id, obj.categories.include?(root)) + root.name + checkbox_subcategory_list(root, obj)))
    end
    list
  end
  
  def checkbox_subcategory_list root, obj
    list = ''
    root.children.each do |cat|
      list += content_tag(:li, check_box_tag("product[category_ids][]", cat.id, obj.categories.include?(cat)) + cat.name + checkbox_subcategory_list(cat, obj))
    end  
    #	  list += content_tag(:li, link_to("Nowa", new_admin_category_path)) if admin
    list.present? ? content_tag(:ul, list, :style => 'margin:0;') : ''
  end

end
