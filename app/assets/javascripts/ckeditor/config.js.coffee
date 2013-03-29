CKEDITOR.editorConfig = (config) ->
  config.language = 'en'
  config.width = '625'
  config.height = '200'
  config.toolbar_Pure = [
    
    { name: 'clipboard',   items: [ 'Cut','Copy','Paste','PasteText','-','Undo','Redo' ] },
    { name: 'editing',     items: [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
   
   
    
  ]
  config.toolbar = 'Pure'
  true