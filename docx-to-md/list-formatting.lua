local List = require 'pandoc.List'

function compactifyItem (blocks)
  return (#blocks == 1 and blocks[1].t == 'Para')
    and {pandoc.Plain(blocks[1].content)}
    or blocks
end

function compactifyList (l)
  l.content = List.map(l.content, compactifyItem)
  return l
end

return {{
    BulletList = compactifyList,
    OrderedList = compactifyList
}}
