;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start

;--------------------------------------------------------------------------------------------------------------
;可选择显示图形的面板x,y,name,use(visible),flagname,cond
;类型pic/num,数值演示图形num,字间距space
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduPicLayer extends uiLayer
{
var name;
var flagname;
var pic;
var num;
var space;
var cond;
var ctype="pic";
  //---------------------------------------------------坐标---------------------------------------------------
	function drawXY()
	{
		var text_x=230;
		var text_y=75;

		 with(kag.fore.layers[3])
		 {
		   .font.height=18;
		   .fillRect(sf.gs.width+text_x,text_y,100,20,0xFFD4D0C8);
		   .drawText(sf.gs.width+text_x,text_y, "("+left+","+top+")", 0x000000);
		 }
	}
 //---------------------------------------------------创建---------------------------------------------------
   function uiEduPicLayer(name,elm)
  {
         super.Layer(kag, parent);

	  left=elm.x;
	  top=elm.y;
	  visible=elm.use;
	  
         this.name=name;
         this.flagname=elm.flagname;
         this.pic=elm.pic;
         this.num=elm.num;
         this.space=elm.space;
         this.cond=elm.cond;
         
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		
	drawSelect();
		
  }
 //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect()
  {

    this.name=name;
    this.flagname=flagname;
    
    //根据不同类型描绘演示图形或者描绘数字
    if (pic!=void)
    {
      loadImages(pic);
      setSizeToImageSize();
    }
    else
    {
      //读取数字图片大小
      var sizelayer=new global.Layer(window, parent);
      sizelayer.loadImages(num+0);
      sizelayer.setSizeToImageSize();
      
      this.width=space*3;
      this.height=sizelayer.height;
      
      //设定图层本身大小
      var sw=sizelayer.width;
      var sh=sizelayer.height;
      this.fillRect(0,0,width,height,0x00FFFFFF);
      
      //在图片上进行描绘
      this.operateRect(0, 0, sizelayer, 0, 0, sw, sh);
      sizelayer.loadImages(num+1);
      this.operateRect(space, 0, sizelayer, 0, 0, sw, sh);
      sizelayer.loadImages(num+2);
      this.operateRect(space*2, 0, sizelayer, 0, 0, sw, sh);
    }
    
	//描绘边框
	DrawSelectFrame();
   }
   //---------------------------------------------------输出---------------------------------------------------
   function LayerElm()
   {
      var dic=new Dictionary();
      //将该层的位置输出，供字典保存用
      dic.use=this.visible;
      
      dic.x=this.left;
      dic.y=this.top;

      dic.name=this.name;
      dic.flagname=this.flagname;
      dic.cond=this.cond;
      
      dic.pic=this.pic;
      dic.num=this.num;
      dic.space=this.space;

      dic.ctype="pic";

      return dic;

   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
   
   this.visible=elm.use;
   this.left=elm.x;
   this.top=elm.y;
   
   this.name=elm.name;
   this.flagname=elm.flagname;
   this.cond=elm.cond;
   
   this.pic=elm.pic;
   this.num=elm.num;
   this.space=elm.space;
   
    this.drawSelect();
   }
   
   

}
[endscript]
[return]
