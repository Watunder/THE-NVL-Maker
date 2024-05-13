;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;-----------------------------------------------------------------------------------
;悬停显示的图片位置
;-----------------------------------------------------------------------------------
[iscript]
class uiCgThumLayer extends uiLayer
{

	var pic;
	var thum;
	var thumx;
	var thumy;

	var type="cgThum";

  //---------------------------------------------------创建---------------------------------------------------
  function uiCgThumLayer(elm,dic)
  {
        super.Layer(kag, parent);

        //loadImages(pic);
        //setSizeToImageSize();
        
        //fillRect(0,0,width,height,0xFFFFFFFF);
        
		left=elm[0];
		top=elm[1];
		visible=true;
		this.pic=dic.normal;
		this.thum=dic.thum;
		this.thumx=dic.x;
		this.thumy=dic.y;

		dic.type=this.type;

		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		drawSelect();
  }
    //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {
  
    //width=this.width;
    //height=this.height;
    
    //fillRect(0,0,width,height,0xFFFFFFFF);
	if (isPicExist(pic))
	{
    	loadImages(pic);
	}
	else
	{
		loadImages("edit_button_close");
	}
    setSizeToImageSize();
	
	//添加thum小图标
	var temp = window.temporaryLayer;
	if (isPicExist(thum))
	{
		temp.loadImages(thum);
	}
	else
	{
		loadImages("edit_button_close");
	}
	var w = temp.imageWidth;
	var h = temp.imageHeight;

    fillRect(thumx,thumy,w,h,0x66FFFFFF);

	//描绘边框
	DrawSelectFrame();
  }

}
[endscript]
[return]
