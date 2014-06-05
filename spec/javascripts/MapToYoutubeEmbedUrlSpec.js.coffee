describe "MapToYoutubeEmbedUrlSpec", ->
  it 'test youtube url conversion', ->

    expect('123').toEqual mapToYoutubeEmbedUrl('123')
    expect('').toEqual mapToYoutubeEmbedUrl('')
    expect('').toEqual mapToYoutubeEmbedUrl()
    expect('http://www.youtube.com/embed/9gAziU7MdDc').toEqual mapToYoutubeEmbedUrl('http://www.youtube.com/embed/9gAziU7MdDc')
    expect('http://www.youtube.com/embed/e3vRCvRVtRg?rel=0&amp;wmode=transparent').toEqual mapToYoutubeEmbedUrl('http://youtu.be/e3vRCvRVtRg?a')
    expect('http://www.youtube.com/embed/e3vRCvRVtRg?rel=0&amp;wmode=transparent').toEqual mapToYoutubeEmbedUrl('http://youtu.be/e3vRCvRVtRg')
    expect('http://www.youtube.com/embed/hCck08gEfW4?rel=0&amp;wmode=transparent').toEqual mapToYoutubeEmbedUrl('http://www.youtube.com/watch?v=hCck08gEfW4&feature=youtu.be')

#  http://www.youtube.com/embed/9gAziU7MdDc
#http://www.youtube.com/embed/617ANIA5Rqs?rel=0&wmode=transparent
#http://youtu.be/e3vRCvRVtRg?a
#http://www.youtube.com/watch?v=hCck08gEfW4&feature=youtu.be
