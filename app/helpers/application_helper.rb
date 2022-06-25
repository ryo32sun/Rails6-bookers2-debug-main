module ApplicationHelper
  
  def sort_order(column, title, hash_param = {})
    direction = column == sort_column && sort_direction == 'desc' ? 'asc' : 'desc'
    link_to title, { sort: column, direction: direction }.merge(hash_param)
  end
  
end
