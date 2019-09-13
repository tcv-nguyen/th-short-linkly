module ControllerHelpers
  def send_multiple_request(counter)
    counter.times { get :show, params: { id: short_link.encoded_id, user_id: 1 } }
  end

  def analytic_counter_should_eq_to(number)
    analytic
    body = JSON.parse(response.body)
    expect(body['counter']).to eq(number)
  end
end
