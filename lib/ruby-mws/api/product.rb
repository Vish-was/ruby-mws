module MWS
  module API

    class Product < Base
      def_request :get_matching_product_for_id,
        :verb => :get,
        :uri => '/Products/2011-10-01',
        :version => '2011-10-01',
        :lists => {
          :seller_sku => "IdList.Id"
        },
        :mods => [
          lambda {|r| r.products = r.products.product if r.products}
        ]
    end

  end
end
