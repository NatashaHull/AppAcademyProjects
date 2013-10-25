a = Link.new(title:"fun stuff", description:"", url:"reddit")
a.author_id = 3
a.save!

c1 = Comment.new(link_id: 1, content: "Grandpa", parent_id: nil)
c1.author_id = 1
c1.save!

c2 = Comment.new(link_id: 1, content: "Father", parent_id: 1)
c2.author_id = 2
c2.save!

c3 = Comment.new(link_id: 1, content: "Child", parent_id: 2)
c3.author_id = 3
c3.save!

c4 = Comment.new(link_id: 1, content: "Mother", parent_id: 1)
c4.author_id = 4
c4.save!

c5 = Comment.new(link_id: 1, content: "Grandma", parent_id: nil)
c5.author_id = 5
c5.save!

c6 = Comment.new(link_id: 1, content: "Grandchild", parent_id: 3)
c6.author_id = 6
c6.save!