json.array!(@download_tickets) do |download_ticket|
  json.extract! download_ticket, :id
  json.url download_ticket_url(download_ticket, format: :json)
end
