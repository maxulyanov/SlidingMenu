# SlidingMenu
Magic sliding menu

## Getting started
1. Include jQuery
2. Include SlidingMenu files (js and css)
3. Create SlidingMenu with your options after window load

```html
<link rel="stylesheet" href="SlidingMenu.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="SlidingMenu.js"></script>
<script>
    $(window).on('load', function() {
    
      var $menu = $('.menu-example-id-1');
      var $items = $menu.find('.menu-example__item');
      new SlidingMenu({
        'menu': $menu,
        'items': $items,
      });
    
    })
</script>
```

## Options

### Required:

<code>menu</code> — Wrapper items menu (jQuery object)<br>
<code>items</code> — Items menu (jQuery object)<br>
### Not required:

<code>itemActiveClass</code> — Active class current item menu (String). Default: 'active'<br>
<code>slidingClass</code> — Custom class sliding element (String). Default: ' '<br>
<code>direction</code> — Direction float sliding 'x' or 'y' (String). Default: 'x'<br>
<code>duration</code> — duration animation in mc (Number). Default: 400<br>

## Callbacks

<code>over</code> — Call function during hover menu items<br>
<code>leave </code>— Call function during leave from wrapper menu

```html
<script>
$(window).on('load', function() {

  var $menu = $('.menu-example-id-1');
  var $items = $menu.find('.menu-example__item');
  new SlidingMenu({
    'menu': $menu,
    'items': $items,
  },
  {
    'over': over,
    'leave': leave
  });

  function over(current, data) {
    console.log('hover menu items')
  }

  function leave(current, data) {
    console.log('leave menu')
  }

});
</script>
```

## Browser Support

All modern browsers and IE9+

## Example

See detail example - <a href="http://m-ulyanov.github.io/sliding-menu/ ">SlidingMenu</a>
