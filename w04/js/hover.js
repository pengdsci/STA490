function mouseIn() {
  $('.img').addClass('show');
}

function mouseOut() {
  $('.img').removeClass('show');
}

$('.hover-me').hover(mouseIn, mouseOut);
.img  {
  display: none;
}
.img.show {
  display: block;
}

$('[data-toggle="tooltip"]').tooltip();
  $(document).ready(function() {
    $('[data-toggle="tooltip"]').tooltip();
  }); 


/** **/

/*<style>*/
.tooltip {
    display:inline-block;
    position:relative;
    border-bottom:1px dotted #666;
    text-align:left;
}

.tooltip .right {
    min-width:200px; 
    top:50%;
    left:100%;
    margin-left:20px;
    transform:translate(0, -50%);
    padding:10px 20px;
    color:#000000;
    background-color:#EEEEEE;
    font-weight:normal;
    font-size:13px;
    border-radius:8px;
    position:absolute;
    z-index:99999999;
    box-sizing:border-box;
    box-shadow:0 1px 8px rgba(0,0,0,0.5);
    visibility:hidden; opacity:0; transition:opacity 0.8s;
}

.tooltip:hover .right {
    visibility:visible; opacity:1;
}

.tooltip .right i {
    position:absolute;
    top:50%;
    right:100%;
    margin-top:-12px;
    width:12px;
    height:24px;
    overflow:hidden;
}

.tooltip .right i::after {
    content:'';
    position:absolute;
    width:12px;
    height:12px;
    left:0;
    top:50%;
    transform:translate(50%,-50%) rotate(-45deg);
    background-color:#EEEEEE;
    box-shadow:0 1px 8px rgba(0,0,0,0.5);
}
/*</style>*/








