;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;--------------------------------------------------------------------------------------------------------------
;带悬停效果的伪按钮层,输出x,y,normal,over,on,use(visible)
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiButtonLayer extends uiLayer
{
	var normal;
	var over;
	var on;
	var enterse;
	var clickse;
	
	var usetext;
	var fontface;
	var text;
	var textsize;
	var normalcolor;
	var overcolor;
	var oncolor;

	var type="button";
  //---------------------------------------------------创建---------------------------------------------------
  function uiButtonLayer(elm)
  {
     	super.Layer(kag, parent); 

		visible=elm.use;
		
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		//读取参数
		Reset(elm);

  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal,stnum=0)
  {
	dm(state);

	if (isPicExist(state))
	{
	    this.loadImages(state);
	}
	else
	{
	    this.loadImages("edit_button_close");
	}
    this.setSizeToImageSize();

	if (usetext && text!=void)
	{
		//文字大小
		this.font.height=(int)textsize;
		//坐标
		var x=(this.width-font.getTextWidth(text))/2;
		var y=(this.height-font.getTextHeight(text))/2;
		//颜色
		var cur_color;
		if (stnum==0) cur_color=normalcolor;
		else if (stnum==1) cur_color=overcolor;
		else cur_color=oncolor;
	
		drawText(x,y,text,cur_color);
	}
	//描绘边框
	DrawSelectFrame();
  }
   //---------------------------------------------------悬停---------------------------------------------------
   function onMouseEnter()
   {
      drawSelect(over,1);

      if (enterse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
		//去掉扩展名
		enterse=Storages.chopStorageExt(enterse);
		if (Storages.isExistentStorage(enterse+".wav") || Storages.isExistentStorage(enterse+".ogg"))
		{
	         kag.tagHandlers.playse(%[
	         "storage" => enterse,
	         "loop" => false
	         ]);
		}
      }
   }
   function onMouseLeave()
   {
      drawSelect(normal,0);
   }
   function onClick()
   {
      drawSelect(on,2);

      if (clickse!=void && kag.fore.layers[5].visible==false && kag.fore.layers[7].visible==false) 
      {
		//去掉扩展名
		clickse=Storages.chopStorageExt(clickse);
		if (Storages.isExistentStorage(clickse+".wav") || Storages.isExistentStorage(clickse+".ogg"))
		{
	         kag.tagHandlers.playse(%[
	         "storage" => clickse,
	         "loop" => false
	         ]);
		}
      }
   }
   //---------------------------------------------------输出---------------------------------------------------
   function ButtonElm()
   {
      var dic=new Dictionary();
      //将该层的各数据输出，供字典保存用
      dic.normal=this.normal;
      dic.over=this.over;
      dic.on=this.on;

      dic.x=this.left;
      dic.y=this.top;

      dic.use=this.visible;

      dic.enterse=this.enterse;
      dic.clickse=this.clickse;

      dic.usetext=this.usetext;
      dic.fontface=this.fontface;
      dic.textsize=this.textsize;
      dic.text=this.text;

      dic.normalcolor=this.normalcolor;
      dic.overcolor=this.overcolor;
      dic.oncolor=this.oncolor;

      dic.type=this.type;

      return dic;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
	    this.normal=elm.normal;
	    this.over=elm.over;
	    this.on=elm.on;
	    this.left=elm.x;
	    this.top=elm.y;
	    this.enterse=elm.enterse;
	    this.clickse=elm.clickse;
	
		//设定使用文字
		this.usetext=elm.usetext;
		this.fontface=elm.fontface;
		this.textsize=elm.textsize;
		this.text=elm.text;
	
		this.normalcolor=elm.normalcolor;
		this.overcolor=elm.overcolor;
		this.oncolor=elm.oncolor;
	
	    this.drawSelect();
   }
}
[endscript]
[return]
