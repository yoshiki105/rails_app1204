names = %w[Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom]
fnames = %W[\u4F50\u85E4 \u9234\u6728 \u9AD8\u6A4B \u7530\u4E2D]
gnames = %W[\u592A\u90CE \u6B21\u90CE \u82B1\u5B50]
0.upto(9) do |idx|
  Member.create(
    number: idx + 10,
    name: names[idx],
    full_name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    email: "#{names[idx]}@example.com",
    birthday: '1981-12-01',
    sex: [1, 1, 2][idx % 3],
    administrator: idx.zero?,
    password: 'pass1234',
    password_confirmation: 'pass1234'
  )
end
