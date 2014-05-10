json.results @records do |record|
  json.id record.id
  json.text record.send(params[:column]).to_s
end
json.more !@records.last_page?