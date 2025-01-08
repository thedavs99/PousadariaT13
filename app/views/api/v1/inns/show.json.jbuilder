json.name @inn.name
json.registration_number @inn.registration_number
json.description @inn.description
json.address do
  json.address @inn.address.address
  json.number @inn.address.number
  json.city @inn.address.city
end
json.inn_owner do
  json.name @name
  json.email @inn.inn_owner.email
end

json.inn_rooms @inn.inn_rooms.each do |ir|
  json.name ir.name
  json.guest_limit ir.guest_limit
end