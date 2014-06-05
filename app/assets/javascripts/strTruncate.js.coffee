window.strTruncate = (str, size) ->
  return "" if str == undefined

  newstr = str.slice 0,size
  newstr = newstr + "..." if str.length > size
  return newstr
