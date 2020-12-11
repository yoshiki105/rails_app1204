body =
  "複素数体であれば、任意のCM-タイプの A は、実際、数体である\n" \
  '定義体（英語版）(field of definition)を持っている。' \
  "自己準同型環の可能なタイプは、対合（ロサチの対合（英語版）(Rosati involution）\n" \
  'をもつ環として既に分類されていて、CM-タイプのアーベル多様体の分類を導き出す。'

%w[Taro Jiro Hana].each do |name|
  member = Member.find_by(name: name)
  0.upto(9) do |idx|
    Entry.create(
      member_id: member.id,
      title: "エントリ#{idx}",
      body: body,
      posted_at: 10.days.ago.advance(days: idx),
      status: %w[draft member_only public][idx % 3]
    )
  end
end
