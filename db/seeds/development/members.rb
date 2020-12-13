names = %w[Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom]
fnames = %W[\u4F50\u85E4 \u9234\u6728 \u9AD8\u6A4B \u7530\u4E2D]
gnames = %W[\u592A\u90CE \u6B21\u90CE \u82B1\u5B50]
password = 'password'

0.upto(9) do |idx|
  Member.create(
    number: idx + 10,
    name: names[idx],
    full_name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    email: "#{names[idx]}@example.com",
    birthday: '1981-12-01',
    sex: [1, 1, 2][idx % 3],
    administrator: idx.zero?,
    password: password,
    password_confirmation: password
  )
end

0.upto(29) do |idx|
  Member.create(
    number: idx + 20,
    name: "John#{idx + 1}",
    full_name: "John Doe#{idx + 1}",
    email: "John#{idx + 1}@example.com",
    birthday: '1981-12-01',
    sex: 1,
    administrator: false,
    password: password,
    password_confirmation: password
  )
end

filename = 'profile.png'
path = Rails.root.join(__dir__, filename)
m = Member.find_by!(number: 10)

File.open(path) do |f|
  m.profile_picture.attach(io: f, filename: filename)
end
