describe "TruncateSpec", ->
  it 'truncates as required', ->

    expect("").toEqual strTruncate(undefined,20)
    expect("").toEqual strTruncate("",20)
    expect("123").toEqual strTruncate("123",20)
    expect("12345678901234567890...").toEqual strTruncate("123456789012345678901",20)
    expect("1234...").toEqual strTruncate("12345",4)
    expect("12...").toEqual strTruncate("12345",2)
    expect("12345").toEqual strTruncate("12345",5)
