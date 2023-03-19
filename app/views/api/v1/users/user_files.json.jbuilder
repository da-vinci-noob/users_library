json.email current_user.email
json.files(@files) do |f|
  json.id f.id
  json.name f.file.filename
  json.uploaded_by f.user.email
  json.private yes_no(f.private)
  json.size number_to_human_size(f.file.byte_size)
  json.url f.file.url
  json.created_at f.file.created_at.strftime("%d-%b-%Y")
end

