json.array!(@messages) do |message|
  json.extract! message, :id, :posted_by, :posted_to, :content
  json.url message_url(message, format: :json)
end
