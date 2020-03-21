def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  item = nil
  
  while index < collection.length do
    if name == collection[index][:item]
      item = collection[index]
      break
    end
    index += 1
  end
  item
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  outer_index = 0
  unique_items = cart
  while outer_index < cart.length do
    checker = cart[outer_index][:item]
    counter = 0
    
    inner_index = 0
    while inner_index < cart.length do
      if cart[inner_index][:item] == checker
        counter += 1
      end
      inner_index += 1
    end
    
    unique_items[outer_index][:count] = counter
    outer_index += 1
  end
  
  unique_items.uniq
  
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  outer_index = 0
  while outer_index < coupons.length do
    
    inner_index = 0
    while inner_index < cart.length do
      
      if coupons[outer_index][:item] == cart[inner_index][:item]
        item = cart[inner_index][:item]
        remainder = cart[inner_index][:count] % coupons[outer_index][:num]
        applied = cart[inner_index][:count] - remainder
        discount = coupons[outer_index][:cost] / coupons[outer_index][:num]
        cart << {
          :item => "#{item} W/COUPON",
          :price => discount,
          :clearance => cart[inner_index][:clearance],
          :count => applied
        }
        cart[inner_index][:count] = remainder
        break
      end
      
      inner_index += 1
    end
  
    outer_index += 1
  end
  
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < cart.length do
    if cart[index][:clearance]
      price = cart[index][:price] * 0.8
      cart[index][:price] = price.round(2)
    end
    index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  total = 0
  grand_total = 0
  
  index = 0
  while index < cart.length do
    total += cart[index][:price] * cart[index][:count]
    index += 1
  end
  
  if total > 100
    grand_total = total * 0.9
  else
    grand_total = total
  end
  
  grand_total.round(2)
end
