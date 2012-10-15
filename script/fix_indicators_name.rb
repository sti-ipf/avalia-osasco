Indicator.all.each do |i|
  name = i.name[4..i.name.length]

  while(%w(1, 2, 3, 4, 5, 6, 7, 8, 9, 0).include?(name[0]))
    name = name[2..name.length]
  end
  i.name = name
  i.save
end