Module.register('textarea-autoexpand', function() {
  'use strict';

  $(document).on('focus.textarea', '.autoExpand', function(){
    var savedValue = this.value;
    this.value = '';
    this.baseScrollHeight = this.scrollHeight;
    this.value = savedValue;
  })

  $(document).on('input.textarea', '.autoExpand', function(){
    var minRows = this.getAttribute('data-min-rows')|0,
       rows;
    this.rows = minRows;
      console.log(this.scrollHeight , this.baseScrollHeight);
    rows = Math.ceil((this.scrollHeight - this.baseScrollHeight) / 17);
    this.rows = minRows + rows;
  });

});