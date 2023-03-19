json.files(@files) do |f|
  json.id f.file.id
  json.name f.file.filename
  json.private yes_no(f.private)
  json.uploaded_by f.user.email
  json.size number_to_human_size(f.file.byte_size)
  json.url f.file.url
  json.created_at f.file.created_at.strftime("%d-%b-%Y")
end

