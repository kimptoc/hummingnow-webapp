describe "HtmlEntitiesSpec", ->
  it 'convert only specified fields', ->
    src = "123"
    expect(src).toEqual htmlEntities(src)

    expect('123&quot;').toEqual htmlEntities('123"')
    expect('').toEqual htmlEntities('')
    expect('').toEqual htmlEntities()
    expect('&lt;&gt;&amp;&quot;').toEqual htmlEntities('<>&"')