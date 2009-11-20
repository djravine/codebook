// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults





function close_box() {
		var FlashBox = document.getElementById("loading_panel");
		FlashBox.style.display = "none";
		FlashBox.style.opacity = 0;
		FlashBox.style.zIndex = -255;
}

function open_box(html_content) {
    // open a welcome message as soon as the window loads
    Shadowbox.open({
        content:    "<div id='welcome-msg' class='flash_text_box'><div class='flash_text' align='center'>"+html_content+"</div></div>",
        player:     "html",
        title:      "<span class='flash_text_title'><b>NOTICE</b></span>",
        height:     300,
        width:      500
    });
}









// TAB / PANELS

function tabselect(tab) {
  var tablist = $('tabcontrol1').getElementsByTagName('li');
  var nodes = $A(tablist);
  var lClassType = tab.className.substring(0, tab.className.indexOf('-') );

  nodes.each(function(node){
    if (node.id == tab.id) {
      tab.className=lClassType+'-selected';
    } else {
      node.className=lClassType+'-unselected';
    };
  });
}

function paneselect(pane) {
  var panelist = $('panecontrol1').getElementsByTagName('li');
  var nodes = $A(panelist);

  nodes.each(function(node){
    if (node.id == pane.id) {
      pane.className='pane-selected';
    } else {
      node.className='pane-unselected';
    };
  });
}

function loadPane(pane, src) {
  if (pane.innerHTML=='' || pane.innerHTML=='<img alt="Wait" src="/images/spinner.gif" style="vertical-align:-3px" /> Loading...') {
    reloadPane(pane, src);
  }
}

function reloadPane(pane, src) {
  new Ajax.Updater(pane, src, {asynchronous:1, evalScripts:true, onLoading:function(request){pane.innerHTML='<img alt="Wait" src="/images/spinner.gif" style="vertical-align:-3px" /> Loading...'}})
}
