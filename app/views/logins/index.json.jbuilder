json.array!(@logins) do |login|
  json.extract! login, :id, :name
  json.url login_url(login, format: :json)
end
