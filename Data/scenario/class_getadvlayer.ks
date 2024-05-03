;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------
;自定义用于设置adv点的层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class getAdvLayer extends Layer
{
   //左上，宽高定义
	var x;
	var y;
	var r_width;
	var r_height;

	var normal;
	var over;
	var on;

   //是否拖动中
   var pick;
   //父层
   var parent=kag.fore.layers[8];

   //var frame;
   
function finalize() 
{
	this.visible=false;
	super.finalize(...);
}
//创建层
    function getAdvLayer(width,height,elm)
  {
	//width,height,x,y,r_width,r_height
    super.Layer(kag, parent);

	left=0;
	top=0;

	this.width=width;
	this.height=height;
	
	this.fillRect(0,0,width,height,0x00FFFFFF);

	//loadImages(frame);
	//setSizeToImageSize();
	
	this.x=elm.x;
	this.y=elm.y;
	
	this.r_width=elm.width;
	this.r_height=elm.height;

	 
	 drawMargin();

	 visible=true;
	 
	 hitType = htMask;
	 hitThreshold =0;

  }
//按下
   function onMouseDown(x, y, button, shift)
{
   if (button==mbLeft)
   {

	dm("鼠标按下"+this.cursorX);

     this.x=this.cursorX;
     this.y=this.cursorY;

     pick=true;
     drawMargin();
    }
}
//抬起
function onMouseUp(x, y, button, shift)
{
   if (button==mbLeft)
   {
      pick=false;
      drawMargin();
    }
}
//移动
  function onMouseMove(x, y, shift)
  {
    if (pick)
    {
        r_width=this.cursorX-this.x;
        r_height=this.cursorY-this.y;
        drawMargin();
    }
  }
//描绘
   function drawMargin()
   {
	 //loadImages(frame);
	this.width=width;
	this.height=height;
	this.fillRect(0,0,width,height,0x00FFFFFF);

     fillRect(x,y,r_width,1,0xFFFF0000);
     fillRect(x,y+r_height,r_width,1,0xFFFF0000);
     fillRect(x,y,1,r_height,0xFFFF0000);
     fillRect(x+r_width,y,1,r_height,0xFFFF0000);

     drawMarginXY();
   }

//坐标
function drawMarginXY()
{
   with(kag.fore.layers[7])
   {
      .fillRect(sf.gs.width+55,75,120,80,0xFFD4D0C8);
      .font.height=18;
      .drawText(sf.gs.width+55,75,"x = "+x , 0x000000);
      .drawText(sf.gs.width+55,95,"y = "+y , 0x000000);
      .drawText(sf.gs.width+55,115,"width = "+r_width , 0x000000);
      .drawText(sf.gs.width+55,135,"height = "+r_height , 0x000000);
   }
}
//输出
   function MarginElm()
   {
      //var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      f.参数.x=this.x;
      f.参数.y=this.y;
	
      f.参数.width=this.r_width;
      f.参数.height=this.r_height;
	
   }
}
[endscript]

[return]
