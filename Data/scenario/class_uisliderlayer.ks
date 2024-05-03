;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;--------------------------------------------------------------------------------------------------------------
;带有拖动按钮(伪)的slider层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiSliderLayer extends uiLayer
{
   var base;
   var normal;
   var over;
   var on;
  //---------------------------------------------------创建---------------------------------------------------
  function uiSliderLayer(elm)
  {
     	super.Layer(kag, parent);
     	base=elm.base;
     	normal=elm.normal;
     	over=elm.over;
     	on=elm.on;
		left=elm.x;
		top=elm.y;
		visible=elm.use;
		//复制图片层及按钮
              drawSelect();

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal)
  {
  //清空图层
    fillRect(0,0,width,height,0x00FFFFFF);
    //重载数据
        var baseImage=new global.Layer(window, parent);
		//载入图片
		if (isPicExist(base))
		{
		    baseImage.loadImages(base);
		}
		else
		{
		    baseImage.loadImages("edit_button_close");
		}
        baseImage.setSizeToImageSize();
        width= baseImage.width;
        height=baseImage.height;
        this.operateRect(0, 0, baseImage, 0, 0, width, height);
        
        var tabImage=new global.Layer(window, parent);
		//载入图片
		if (isPicExist(state))
		{
		    tabImage.loadImages(state);
		}
		else
		{
		    tabImage.loadImages("edit_button_close");
		}
        tabImage.setSizeToImageSize();
        var twidth  = tabImage.width;
        var theight = tabImage.height;
        this.operateRect((width - twidth) / 2, (height - theight) / 2, tabImage, 0, 0, twidth, theight);
	//描绘边框
	DrawSelectFrame();
  }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.normal=elm.normal;
    this.over=elm.over;
    this.on=elm.on;
    this.base=elm.base;
    this.left=elm.x;
    this.top=elm.y;
    this.drawSelect();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function SliderElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.x=this.left;
      dic.y=this.top;
      dic.base=this.base;
      dic.normal=this.normal;
      dic.over=this.over;
      dic.on=this.on;
      dic.use=this.visible;
      return dic;
   }
}
[endscript]
[return]
