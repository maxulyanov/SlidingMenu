###
 SlidingMenu Constructor 1.0
 Author: M.Ulyanov
 Created: 05/12/2015
###

class window.SlidingMenu

  @itemActive;
  @activeState;
  @sliding;
  @defaultData;
  @options;
  @callbacks;

  # #
  constructor: (options, callbacks) ->

    @options =
      'menu' : options.menu,
      'items': options.items,
      'itemActiveClass': options.itemActiveClass ?= 'active',
      'slidingClass': options.slidingClass ?= '',
      'duration': options.duration ?= 400,
      'direction': options.direction ?= 'x'

    @callbacks =
      'over' : null,
      'leave': null

    if callbacks? then @callbacks = callbacks;

    do @createSliding;
    do @setActiveState;
    do @setDOMEvents;

  # #
  createSliding: () =>
    @sliding = $('<div class="menu-sliding ' + @options.slidingClass + '"></div>');
    @sliding.appendTo(@options.menu);

  # #
  setActiveState: () =>
    @options.items.each (index, value) =>
      if($(value).hasClass(@options.itemActiveClass)) then @itemActive = $(value);

    if @itemActive?
      @activeState = true;
      do @setDefaultData;
    else
      @activeState = false;

  # #
  setDefaultData: () =>
    @defaultData =
      'left'  : @itemActive.offset().left - @options.menu.offset().left,
      'top'   : @itemActive.offset().top - @options.menu.offset().top
      'width' : @itemActive.outerWidth()
      'height': @itemActive.outerHeight();

    do @setSlidingData;

  # #
  setSlidingData: () =>
    @sliding.css
      'width' : @defaultData.width,

    if @options.direction is 'x'
      @sliding.css
        'left': @defaultData.left
    else if @options.direction is 'y'
      @sliding.css
        'height' : @defaultData.height,
        'top' : @defaultData.top
    else
      errorReport("#{@options.direction} not support! Used x or y!");

  # #
  setDOMEvents: () ->
    do @setMouseOver;
    do @setMouseLeave;

  # #
  setMouseOver: () =>
    @options.items.on 'mouseover', (event) =>

      if event.currentTarget isnt event.target then return;

      $self = $(event.target);
      if not @itemActive
        @itemActive = $self;
        do @setDefaultData;

      if @callbacks.over?
          @callbacks.over($self, {@itemActive, @activeState, @sliding, @options});

      @sliding.css('opacity', 1);
      if @options.direction is 'x'
        animateOptions =
          'left'  : $self.offset().left - @options.menu.offset().left,
          'width' : $self.outerWidth()
      else if @options.direction is 'y'
        animateOptions =
          'top' : $self.offset().top - @options.menu.offset().top
      else
        errorReport("#{@options.direction} not support! Used x or y!");

      @sliding.stop().animate(animateOptions, duration: @options.duration);

  # #
  setMouseLeave: () ->
    @options.menu.on 'mouseleave', (event) =>
      $self = $(event.target);
      if not @activeState
        @itemActive = null;
        @sliding.css({
          'opacity' : 0,
          'left'    : 0,
          'with'    : 0
        })
        return;

      if @callbacks.leave?
        @callbacks.leave($self, {@itemActive, @activeState, @sliding, @options});

      if @options.direction is 'x'
        animateOptions =
          'left'  : @defaultData.left,
          'width' : @defaultData.width
      else if @options.direction is 'y'
        animateOptions =
          'top'  : @defaultData.top,
      else
        errorReport("#{@options.direction} not support! Used x or y!");

      @sliding.stop().animate(animateOptions, duration: @options.duration);

  # #
  errorReport = (message) ->
    console.error(message);