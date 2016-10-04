# Created by Will McCreery
# Bing's photo of the day backgroud with a fade to black at the bottom of the screen to make a more usable space for other widgets.

command: """
curl -s 'http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1'
"""
# 
# Set the refresh frequency.
refreshFrequency: '12h'

style: """

  .wrapper
    width: 100%
    display: block
    text-align: center
    position: relative
  
  .wallpaper
    position: fixed
    top: -50%
    left: -50%
    width: 200%
    height: 200%
    z-index: -998
    

  .wallpaper img 
    position: absolute
    z-index: -1000
    top: 0
    left: 0
    right: 0
    bottom: 0
    margin: auto
    min-width: 50%
    min-height: 50%

  .darker 
    background: linear-gradient(to top, #000000, rgba(0,0,0,0) 500px)
    position: absolute
    top: 0
    bottom: 20%
    left: 0
    right: 0
    z-index: -999

    

"""

render: (output) -> """
<div id='background'></div>
"""

# Update the rendered output.
update: (output, domEl) ->
  mydiv = $(domEl).find('#background')
  html = ''
  xmlDoc = $.parseXML( output )
  xml = $( xmlDoc )
  width = $(window).width()
  height = $(window).height()
  imgsrc = 'http://www.bing.com/' + xml.find('urlBase').text() + '_1920x1200.jpg'
  html += "<div class='wrapper'><div class='wallpaper'><img src='" + imgsrc + "' height='" + $(window).height() + "px' /><div class='darker'></div></div>"
  html += "</div>"

  # Set the output
  mydiv.html(html)
