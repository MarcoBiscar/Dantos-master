class StripeService
  def self.create_plan_for goomp
    if goomp.price > 0
      Stripe::Plan.create(
        amount: goomp.price_cents,
        interval: 'month',
        name: goomp.name,
        currency: 'usd',
        id: goomp.slug
      )
    end
  end

  def self.subscribe user, goomp, token
    customer = Stripe::Customer.create(
      :source => token["id"],
      :plan => goomp.slug,
      :email => token["email"]
    )

    user.update stipe_customer_id: customer.id
  end
end