require "pry"


# cart = [
#       {"AVOCADO" => {:price => 3.00, :clearance => true}},
#       {"AVOCADO" => {:price => 3.00, :clearance => true}},
#       {"KALE" => {:price => 3.00, :clearance => false}},
#       {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
#       {"ALMONDS" => {:price => 9.00, :clearance => false}},
#       {"TEMPEH" => {:price => 3.00, :clearance => true}},
#       {"CHEESE" => {:price => 6.50, :clearance => false}},
#       {"BEER" => {:price => 13.00, :clearance => false}},
#       {"BEER" => {:price => 13.00, :clearance => false}},
#       {"BEER" => {:price => 13.00, :clearance => false}},
#       {"BEER" => {:price => 13.00, :clearance => false}},
#       {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
#       {"BEETS" => {:price => 2.50, :clearance => false}},
#       {"SOY MILK" => {:price => 4.50, :clearance => true}}
#     ]
    
cart =
    {
    "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
    "TEMPEH" => {:price => 3.00, :clearance => true, :count => 3},
    "BEETS" => {:price => 2.50, :clearance => false, :count => 3},
    "CHEESE" => {:price => 6.50, :clearance => false, :count => 3},
    "BEER" => {:price => 13.00, :clearance => false, :count => 3},
    "SOY MILK" => {:price => 4.50, :clearance => true, :count => 3}
    }
    
coupons =
    [
      {:item => "AVOCADO", :num => 2, :cost => 5.00} ,
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]    
    
    
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

def apply_clearance(cart)
  cart.each {|key, value|
    key1 = key
      value.each {|key, value|
        if value == true
          cart[key1][:price] = (cart[key1][:price] * 0.8).round(2)
        end
      }
    }
  puts cart 
end

def apply_coupons(cart, coupons)
  new_cart = Hash.new(0)
  coupons.each {|element|
    cart.each {|key, value|
      new_cart[key] = value
      if element[:item] == key && value[:count] >= element[:num]
        new_cart["#{key} W/COUPON"] = {}
        new_cart["#{key} W/COUPON"][:price] = element[:cost] 
        new_cart["#{key} W/COUPON"][:clearance] = value[:clearance]
        new_cart["#{key} W/COUPON"][:count] = 1
        remainder = value[:count] - element[:num]
        # if remainder == 0
        #   new_cart.delete(key)
        # else  
        new_cart[key][:count] = remainder
        # end
      end    
    }
  }
  puts new_cart
end

apply_coupons(cart, coupons)
