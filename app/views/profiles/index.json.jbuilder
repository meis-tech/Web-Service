json.array!(@profiles) do |profile|
  json.extract! profile, :id
  json.url patient_url(profile, format: :json)
end
