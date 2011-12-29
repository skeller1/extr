module Extr

 class RouterController < ApplicationController

  def direct

   if form_data?
    r = ExtDirectFormRequest.new(env)
    p "form post"
    #todo implement form_posts
   else
    p "json post"
    r = ExtDirectJsonRequest.new(request.env)
    body = r.transactions.map(&:response)
   end
   render :json => body

  end


  private

  def form_data?
   request.env['rack.request.form_hash']
  end

 end

end

