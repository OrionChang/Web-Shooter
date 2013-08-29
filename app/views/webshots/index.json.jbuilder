json.array!(@webshots) do |webshot|
  json.extract! webshot, :user_id, :title, :url, :desc, :photo
  json.url webshot_url(webshot, format: :json)
end
