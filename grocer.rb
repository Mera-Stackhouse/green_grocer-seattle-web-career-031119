

def consolidate_cart(cart)
  hash = {}
  cart.each {|element|
    element.each {|key, value|
      key1 = key
      if !hash.has_key?(key)
        hash[key] = Hash.new(0)
      end
      hash[key][:count] += 1
      value.each {|key, value|
        hash[key1][key] = value
      }
    }
  }
  hash
end

def apply_coupons(cart, coupons)
  if coupons.empty?
    cart
  else    
    new_cart = Hash.new(0)
    coupons.each {|element|
      cart.each {|key, value|
        new_cart[key] = value
        if element[:item] == key && value[:count] >= element[:num]
          if new_cart.has_key?("#{key} W/COUPON")
            new_cart["#{key} W/COUPON"][:count] += 1
          else
            new_cart["#{key} W/COUPON"] = {}
            new_cart["#{key} W/COUPON"][:price] = element[:cost] 
            new_cart["#{key} W/COUPON"][:clearance] = value[:clearance]
            new_cart["#{key} W/COUPON"][:count] = 1
          end
          remainder = value[:count] - element[:num]
          new_cart[key][:count] = remainder
        end    
      }
    }
    new_cart
  end
end

def apply_clearance(cart)
  cart.each {|key, value|
    key1 = key
      value.each {|key, value|
        if value == true
          cart[key1][:price] = (cart[key1][:price] * 0.8).round(2)
        end
      }
    }
  cart 
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  applied = apply_coupons(consolidated, coupons)
  last_cart = apply_clearance(applied)
  total = 0
  last_cart.each {|key, value|
    if value[:count] > 0
      total = total + (value[:price] * value[:count])
    end
  }
  if total > 100
    total = (total * 0.9).round(2)
  end
  total
end
