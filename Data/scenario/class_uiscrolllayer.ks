;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;--------------------------------------------------------------------------------------------------------------
;自定义的用于界面设定的层
;滚动条
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiScrollLayer extends uiLayer
{
	var opacity;
	var color;

    var normal;
    var over;
	var on;

	var back;

	var button_w=32;
	var button_h=32;
	var button_color="0xFFFFFF";
	var button_opacity=128;

	var type="scroll";

   //---------------------------------------------------创建---------------------------------------------------
   function uiScrollLayer(elm)
   {
           	super.Layer(kag, parent);

			hitType = htMask;
			hitThreshold =0;
			focusable=true;

			Reset(elm);

   }
   //---------------------------------------------------描绘---------------------------------------------------
   function drawSelect()
   {

       //底	
       	fillRect(0,0,width,height,0xCCFFFFFF);

		if (back!=void)
		{
			if (isPicExist(back))
			{
				loadImages(back);
				setSizeToImageSize();
			}
		}
		else
		{
			if (color!=void && opacity>0)
			{
       			fillRect(0,0,width,height,"0x"+global.d2x(opacity)+color.substr(2,6));
			}
		}

     	//按钮层
        var tabImage=new global.Layer(window, parent);
		if (isPicExist(normal))
		{
			tabImage.loadImages(normal);
	        tabImage.setSizeToImageSize();
		}
		else
		{
			//tabImage.loadImages("edit_button_close");
			tabImage.width=button_w;
			tabImage.height=button_h;
			tabImage.fillRect(0,0,button_w,button_h,"0x"+global.d2x(button_opacity)+button_color.substr(2,6));
		}
	        var twidth  = tabImage.width;
	        var theight = tabImage.height;
        operateRect(0, height-theight, tabImage, 0, 0, twidth, theight);
        
	//描绘边框
	DrawSelectFrame();
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
		left=elm.x;
		top=elm.y;
		
		
		this.visible=elm.use;
		
		this.normal=elm.normal;
		this.over=elm.over;
		this.on=elm.on;
		
		this.back=elm.back;
		
		if (back==void)
		{
			this.height=elm.height;
			this.width=elm.width;
		}
		
		this.color=elm.color;
		this.opacity=elm.opacity;
		
		this.left=elm.x;
		this.top=elm.y;
		
		if (elm.button_w>0) this.button_w=elm.button_w;
		if (elm.button_h>0) this.button_h=elm.button_h;
		
		if (elm.button_color!=void) this.button_color=elm.button_color;
		if (elm.button_opacity!=void) this.button_opacity=elm.button_opacity;

    	this.drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function ScrollElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
		dic.x=this.left;
		dic.y=this.top;
		dic.use=this.visible;
		dic.back=this.back;
		
		dic.normal=this.normal;
		dic.over=this.over;
		dic.on=this.on;
		
		dic.color=this.color;
		dic.opacity=this.opacity;
		
		dic.height=this.height;
		dic.width=this.width;
		
		dic.button_w=this.button_w;
		dic.button_h=this.button_h;
		
		dic.button_opacity=this.button_opacity;
		dic.button_color=this.button_color;

		dic.type=this.type;
      
      return dic;
   }
}
[endscript]
[return]
