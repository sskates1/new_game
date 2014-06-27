class BoundingArea
  attr_accessor :box_list

  def initialize(box_list)
    @box_list = box_list
  end

  def contains_point?(x,y)
    @box_list.each do |box|
      if box.contains_point?(x,y)
        return true
      end
    end
    false
  end
end
