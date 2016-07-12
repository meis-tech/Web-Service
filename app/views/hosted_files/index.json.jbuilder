json.array!(@hosted_files) do |hosted_file|
  json.extract! hosted_file, :id
  json.url hosted_file_url(hosted_file, format: :json)
end
