class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty is empty."
      else 
        @@cart.each do |shopped|
        resp.write "#{shopped}\n"
        end
      end
    elsif req.path.match(/add/)
      search_term = req.params["q"]
      resp.write add_to_cart(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  
  def add_to_cart(search_term)
    if @@cart.include?(search_term)
      return "Already in cart"
    else 
      @@cart << search_term 
      return "Couldn't find. Put in the cart"
    end
  end
end
