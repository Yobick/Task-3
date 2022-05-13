@stock = []
updating = false

def update_stock(line)
  line_data = line.split(",")
  item_in_stock_index = @stock.find_index{|a| a.match?(/#{line_data[1]}/)}

  unless item_in_stock_index.nil?
    item_in_stock = @stock[item_in_stock_index].split(",")

    return if item_in_stock.last == "full"

    item_in_stock.delete_at(2) if
      tem_in_stock.last == "out of stock" &&
      line_data.first.to_i > 0

    item_in_stock[0] = (item_in_stock.first.to_i + line_data.first.to_i).to_s

    @stock[item_in_stock_index] = item_in_stock.join(",")
  else
    @stock << line
  end
end

STDIN.read.split("\n").each do |line|
  break if line == "end"
  next if line == "current_stock"

  if line == "stock_update"
    updating = true
    next
  end

  if updating
    update_stock(line)
  else
    @stock << line
  end
end

puts @stock.join("\n")
