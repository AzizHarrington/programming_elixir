defmodule Tax do
  def apply(orders) do
    orders |> Enum.map(&calculate/1)
  end

  def calculate([id: id, ship_to: state, net_amount: amount]) do
     [
       id: id,
       ship_to: state,
       net_amount: amount,
       total_amount: get_total(amount, Keyword.get(rates, state, 0))
     ]
  end

  def get_total(amount, rate) do
    amount * (1 + rate)
  end

  def rates do
    [ NC: 0.075, TX: 0.08 ]
  end
end

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount:  35.50 ],
  [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 120, ship_to: :NC, net_amount:  50.00 ]
]

IO.inspect Tax.apply orders
