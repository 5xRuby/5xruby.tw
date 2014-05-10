json.results @tags do |tag|
  json.id tag.name
  json.text tag.name
end
json.more !@tags.last_page?