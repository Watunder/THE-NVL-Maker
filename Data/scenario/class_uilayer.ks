;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;--------------------------------------------------------------------------------------------------------------
;自定义的用于界面设定的层-总类
;传入参数为字典类
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiLayer extends Layer
{
  //是否选中
  var select=false;
  //是否拖拽中
  var pick=false;
  //和鼠标游标的相对距离
  var disX;
  var disY;
  //图片
  var frame;
  //父层
  var parent=kag.fore.layers[4];
  //---------------------------------------------------创建---------------------------------------------------
  function uiLayer(elm)
  {
     	super.Layer(kag, parent);

		left=elm.left;
		top=elm.top;
		frame=elm.frame;

		visible=true;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		//描绘
		drawSelect();
  }
  //---------------------------------------------------消除---------------------------------------------------
   function finalize() 
   {
      this.visible=false;
      super.finalize(...);
   }
  //---------------------------------------------------按下---------------------------------------------------
  function onMouseDown(x, y, button, shift)
  {
     if (button==mbLeft)
     {

        disX=this.cursorX;
        disY=this.cursorY;
        setselect();
        drawSelect();
        pick=true;
      //描绘坐标
      drawXY();
     }
   }
   //---------------------------------------------------抬起---------------------------------------------------
  function onMouseUp(x, y, button, shift)
  {
     if (button==mbLeft)
     {
        pick=false;
      }
   }
 //---------------------------------------------------拖动---------------------------------------------------
  function onMouseMove(x, y, shift)
  {
    if (pick && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false)
    {
      this.left=kag.fore.base.cursorX-parent.left-disX;
      this.top=kag.fore.base.cursorY-parent.top-disY;
      //描绘坐标
      drawXY();
    }
  }
 //---------------------------------------------------键盘---------------------------------------------------
 function onKeyDown(key, shift)
 {
   if (select && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false)
   {
      if (key==VK_LEFT && shift==void) left--;
      if (key==VK_RIGHT && shift==void) left++;
      if (key==VK_UP && shift==void) top--;
      if (key==VK_DOWN && shift==void) top++;
      
      if (key==VK_LEFT && shift==ssRepeat) left--;
      if (key==VK_RIGHT && shift==ssRepeat) left++;
      if (key==VK_UP && shift==ssRepeat) top--;
      if (key==VK_DOWN && shift==ssRepeat) top++;
      
      if (key==VK_LEFT && shift==ssShift) left-=10;
      if (key==VK_RIGHT && shift==ssShift) left+=10;
      if (key==VK_UP && shift==ssShift) top-=10;
      if (key==VK_DOWN && shift==ssShift) top+=10;
      drawXY();
   }
 }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
	if (isPicExist(frame))
	{
		loadImages(frame);
	}
	else
	{
		loadImages("edit_button_close");
	}

	setSizeToImageSize();
	DrawSelectFrame();
  }

	function DrawSelectFrame()
	{
	    //假如选中,带边框
	    if (select)
	    {
	      fillRect(0,0,width,1,0xCCFF0000);
	      fillRect(0,0,1,height,0xCCFF0000);
	      fillRect(0,height-1,width,1,0xCCFF0000);
	      fillRect(width-1,0,1,height,0xCCFF0000);
	    }
	}

  //---------------------------------------------------坐标---------------------------------------------------
function drawXY()
{
		var text_x=70;
		var text_y=75;

		 with(kag.fore.layers[3])
		 {
		   .font.height=18;
		   .fillRect(sf.gs.width+text_x,text_y,100,20,0xFFD4D0C8);
		   .drawText(sf.gs.width+text_x,text_y, "("+left+","+top+")", 0x000000);
		 }
}
   //---------------------------------------------------选中---------------------------------------------------
   function setselect()
   {
      //所有层全部unset
      for (var i=0;i<f.uilayer.count;i++)
      {
         if (f.uilayer[i].select)
         {
           f.uilayer[i].select=false;
           f.uilayer[i].drawSelect();
         }
      }
      this.select=true;
      this.drawSelect();
      this.focus();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function LayerElm()
   {
      var dic=new Dictionary();

		//将该层的位置输出，供字典保存用
		dic.left=this.left;
		dic.top=this.top;
		
		return dic;
   }
}
[endscript]
[return]
