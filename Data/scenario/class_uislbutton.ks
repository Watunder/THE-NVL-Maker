;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;-----------------------------------------------------------------------------------
;界面设定用的显示层2-SL系统用
;包含：
;只有位置显示的上下翻按钮及返回按钮
;悬停显示的图片位置
;悬停显示的文字位置
;独立ＳＬ按钮（上面会根据样式描绘文字并可以刷新）
;-----------------------------------------------------------------------------------
;SL按钮
;-----------------------------------------------------------------------------------
[iscript]
class uiSLButton extends uiButtonLayer
{

   var num;

   var type="slButotn";
   
   function uiSLButton(num)
   {
      super.Layer(kag, parent);
      //图象
      normal=f.config_sl.button.normal;
      over=f.config_sl.button.over;
      on=f.config_sl.button.on;
      //编号
      this.num=num;
      //载入图片
		if (isPicExist(normal))
		{
			this.loadImages(normal);
		}
		else
		{
			this.loadImages("edit_button_close");
		}
      	setSizeToImageSize();
      
	  //根据locate显示位置
	  left=f.config_slpos.locate[num][0];
	  top=f.config_slpos.locate[num][1];
	  visible=true;
	  
	  hitType = htMask;
	  hitThreshold =0;
	  focusable=true;
   }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal,color="normal")
  {

    if (isPicExist(state)) 
	{
		this.loadImages(state);
	}
	else
	{
	    this.loadImages("edit_button_close");
	}
    this.setSizeToImageSize();

//默认字体
	this.font.face=f.setting.font.face;
//其他参数
    this.font.bold=f.config_slpos.pagefont.bold;
    this.font.italic=f.config_slpos.pagefont.italic;
    var sha=f.config_slpos.pagefont.shadow;
    var shac=f.config_slpos.pagefont.shadowcolor;
    var edg=f.config_slpos.pagefont.edge;
    var edgc=f.config_slpos.pagefont.edgecolor;
    
//默认颜色
    var color1=f.config_sl.num.normal;
    var color2=f.config_sl.bookmark.normal;
    var color3=f.config_sl.date.normal;
    var color4=f.config_sl.history.normal;
//其他颜色
if (color=="over")
{
       color1=f.config_sl.num.over;
       color2=f.config_sl.bookmark.over;
       color3=f.config_sl.date.over;
       color4=f.config_sl.history.over;
}
if (color=="on")
{
       color1=f.config_sl.num.on;
       color2=f.config_sl.bookmark.on;
       color3=f.config_sl.date.on;
       color4=f.config_sl.history.on;
}
//--------------------------------------------
    if (f.config_slpos.num.use)
{
    //描绘档案名
   this.font.height=f.config_slpos.num.height;
   var x=(int)f.config_slpos.num.x;
   var y=(int)f.config_slpos.num.y;
   var str=f.config_slpos.num.pre+(num*1+1)+f.config_slpos.num.after;
   if (sha) drawText(x,y, str, color1,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color1,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color1);
 }
 //--------------------------------------------
    if (f.config_slpos.bookmark.use)
{
    //描绘章节名
   this.font.height=f.config_slpos.bookmark.height;
   var x=(int)f.config_slpos.bookmark.x;
   var y=(int)f.config_slpos.bookmark.y;
   var str=num+" "+getTransStr("章节名称");
   if (sha) drawText(x,y, str, color2,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color2,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color2);
 }
 //--------------------------------------------
    if (f.config_slpos.date.use)
{
    //描绘日期
   this.font.height=f.config_slpos.date.height;
   var x=(int)f.config_slpos.date.x;
   var y=(int)f.config_slpos.date.y;
   var str="0000/00/00 00:00";
   if (sha) drawText(x,y, str, color3,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color3,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color3);
 }
    if (f.config_slpos.history.use)
{
    //描绘对话记录
   this.font.height=f.config_slpos.history.height;
   var x=(int)f.config_slpos.history.x;
   var y=(int)f.config_slpos.history.y;
   var str="对话记录……";
   if (sha) drawText(x,y, str, color4,255,true,255,shac,0,2,2);
   else if (edg) drawText(x,y, str, color4,255,true,255,edgc,1,0,0);
   else drawText(x,y, str, color4);
 }
    if (f.config_slpos.smallsnap.use)
{
   //描绘按钮小截图
   var width=f.setting.savedata.thumbnailwidth;
   var height=width*sf.gs.height/sf.gs.width;
   fillRect(f.config_slpos.smallsnap.x,f.config_slpos.smallsnap.y,width,height,0xFFFFFFFF);
}

 //--------------------------------------------
	//描绘边框
	DrawSelectFrame();
  }
   //---------------------------------------------------悬停---------------------------------------------------
   function onMouseEnter()
   {
      drawSelect(over,"over");

      if (f.config_sl.button.enterse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => f.config_sl.button.enterse,
         "loop" => false
         ]);
      }

   }
   function onMouseLeave()
   {
      drawSelect(normal,"normal");
   }
   function onClick()
   {
      drawSelect(on,"on");

      if (f.config_sl.button.clickse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
         kag.tagHandlers.playse(%[
         "storage" => f.config_sl.button.clickse,
         "loop" => false
         ]);
      }

   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(num)
   {
      normal=f.config_sl.button.normal;
      over=f.config_sl.button.over;
      on=f.config_sl.button.on;
      this.num=num;
	  drawSelect();
   }
}
[endscript]
;-----------------------------------------------------------------------------------
;只有位置显示的上下翻按钮及返回按钮
;-----------------------------------------------------------------------------------
[iscript]
class uiSLCtrlButton extends uiButtonLayer
{
    var normal;
    var over;
    var on;

    var enterse;
    var clickse;

   //---------------------------------------------------创建---------------------------------------------------
   function uiSLCtrlButton(pic,pos)
   {
      super.Layer(kag, parent);
      //图象描绘
      normal=pic.normal;
      over=pic.over;
      on=pic.on;

      //音声读取
      enterse=pic.enterse;
      clickse=pic.clickse;

      //位置
      left=pos[0];
      top=pos[1];
      visible=pos[2];
      hitType = htMask;
	  hitThreshold =0;
	  focusable=true;
      drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
      function SLlayerElm()
   {
      var array=[];
      array[0]=this.left;
      array[1]=this.top;
      array[2]=this.visible;
      return array;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(pic)
   {
    this.normal=pic.normal;
    this.over=pic.over;
    this.on=pic.on;
    this.drawSelect();
   }
}
[endscript]
;-----------------------------------------------------------------------------------
;悬停显示的图片位置（存档系统小截图）
;-----------------------------------------------------------------------------------
[iscript]
class uiSnapLayer extends uiLayer
{
  //---------------------------------------------------创建---------------------------------------------------
  function uiSnapLayer(elm)
  {
        super.Layer(kag, parent);
        width=f.setting.savedata.thumbnailwidth;
        height=width*sf.gs.height/sf.gs.width;
        fillRect(0,0,width,height,0xFFFFFFFF);
		left=elm.x;
		top=elm.y;
		visible=elm.visible;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
    //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
    width=f.setting.savedata.thumbnailwidth;
    height=width*sf.gs.height/sf.gs.width;
    fillRect(0,0,width,height,0xFFFFFFFF);

	//描绘边框
	DrawSelectFrame();
  }
   //---------------------------------------------------输出---------------------------------------------------
      function SnapElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.visible=this.visible;

      dic.type="snap";

      return dic;
   }
}
[endscript]

;-----------------------------------------------------------------------------------
;悬停显示的文字位置（存档系统悬停文字）
;-----------------------------------------------------------------------------------
[iscript]
class uiTextLayer extends uiLayer
{
var str;
var color;
 //---------------------------------------------------创建---------------------------------------------------
  function uiTextLayer(str,elm,color)
  {
        super.Layer(kag, parent);
        font.height=elm.size;

		//默认字体
		font.face=f.setting.font.face;
		
		left=elm.x;
		top=elm.y;
		visible=elm.use;
		
		//字体
		font.bold=f.config_slpos.pagefont.bold;
		font.italic=f.config_slpos.pagefont.italic;
		this.str=str;
		this.color=color;

		//翻译
		str=getTransStr(str);

	    //取得宽度
		setLayerWidth(str);
		
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		drawSelect();
  }
  
	function setLayerWidth(str)
	{
		//取得宽度
		this.width=this.font.getTextWidth(str);
		this.height=this.font.getTextHeight(str)+5;
	}

 //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
    //字体
    font.bold=f.config_slpos.pagefont.bold;
    font.italic=f.config_slpos.pagefont.italic;
    this.str=str;
    this.color=color;
    
    //取得宽度
	setLayerWidth(str);
    
    fillRect(0,0,width,height,0x00FFFFFF);
    
    if (f.config_slpos.pagefont.shadow)
    {
      drawText(0,0, str, color,255,true,255,f.config_slpos.pagefont.shadowcolor,0,2,2);
    }
    else if (f.config_slpos.pagefont.edge)
    {
      drawText(0,0, str, color,255,true,255,f.config_slpos.pagefont.edgecolor,1,0,0);
    }
    else
    {
      drawText(0, 0, str,color);
    }
	//描绘边框
	DrawSelectFrame();
  }
 //---------------------------------------------------重设---------------------------------------------------
 function Reset(color)
 {
       this.color=color;
       drawSelect();
 }
 //---------------------------------------------------输出---------------------------------------------------
 function TextElm()
 {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.use=this.visible;
      dic.size=this.font.height;

      dic.type="text";

      return dic;
 }
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
