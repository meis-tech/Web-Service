json.array!(@emergency_alerts) do |emergency_alert|
  json.extract! emergency_alert, :id
  json.url emergency_alert_url(emergency_alert, format: :json)
end
