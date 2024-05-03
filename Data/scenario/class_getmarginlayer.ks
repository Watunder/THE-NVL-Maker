*start
;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------
;自定义用于调整窗口margin的层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class getMarginLayer extends Layer
{
   //左上/右下点坐标定义
   var x1;
   var y1;
   var x2;
   var y2;
   //是否拖动中
   var pick;
   //父层
   var parent=kag.fore.layers[8];
   var frame;
   
function finalize() 
{
	this.visible=false;
	super.finalize(...);
}
//创建层
      function getMarginLayer(frame)
  {
     super.Layer(kag, parent);
     left=0;
	 top=0;
	 this.frame=frame;
	 loadImages(frame);
	 setSizeToImageSize();
	 
	 x1=f.参数.marginl;
	 y1=f.参数.margint;
	 x2=this.width-f.参数.marginr;
	 y2=this.height-f.参数.marginb;
	 
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
     x1=this.cursorX;
     y1=this.cursorY;
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
        x2=this.cursorX;
        y2=this.cursorY;
        drawMargin();
    }
  }
//描绘
   function drawMargin()
   {
	 loadImages(frame);
     var width=x2-x1;
     var height=y2-y1;
     fillRect(x1,y1,width,1,0xFFFF0000);
     fillRect(x1,y2,width,1,0xFFFF0000);
     fillRect(x1,y1,1,height,0xFFFF0000);
     fillRect(x2,y1,1,height,0xFFFF0000);
     drawMarginXY();
   }

//坐标
function drawMarginXY()
{
   with(kag.fore.layers[7])
   {
      .fillRect(sf.gs.width+55,75,120,80,0xFFD4D0C8);
      .font.height=16;
      .drawText(sf.gs.width+55,75,"marginl = "+x1 , 0x000000);
      .drawText(sf.gs.width+55,95,"marginr = "+(width-x2) , 0x000000);
      .drawText(sf.gs.width+55,115,"margint = "+y1 , 0x000000);
      .drawText(sf.gs.width+55,135,"marginb = "+(height-y2) , 0x000000);
   }
}
//输出
   function MarginElm()
   {
      f.参数.marginl=x1;
      f.参数.margint=y1;
      f.参数.marginr=this.width-x2;
      f.参数.marginb=this.height-y2;
   }
}
[endscript]

[return]
