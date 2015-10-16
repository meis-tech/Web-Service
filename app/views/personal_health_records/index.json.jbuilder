json.array!(@personal_health_records) do |personal_health_record|
  json.extract! personal_health_record, :id
  json.url personal_health_record_url(personal_health_record, format: :json)
end
