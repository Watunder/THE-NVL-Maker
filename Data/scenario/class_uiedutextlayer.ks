;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;--------------------------------------------------------------------------------------------------------------
;可选择文字描绘效果的面板x,y,name,use(visible),flagname,cond
;color,fontname,size,bold,shadow,shadowcolor,edge,edgecolor
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduTextLayer extends uiLayer
{

var name;
var flagname;
var fontname;
var size;
var color;
var bold;
var shadow;
var shadowcolor;
var edge;
var edgecolor;
var cond;

var ctype="text";

var lineheight;

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
  function uiEduTextLayer(name,elm)
  {
        super.Layer(kag, parent);

		left=elm.x;
		top=elm.y;
		visible=elm.use;
		this.name=elm.name;
		this.flagname=elm.flagname;
		this.cond=elm.cond;
		this.lineheight=elm.lineheight;
         
	  	//设定文字默认高度
        this.font.height=f.setting.font.size;

        //改变设定
        fontname=elm.fontname;
        size=elm.size;
        color=elm.color;
        bold=elm.bold;
        shadow=elm.shadow;
        shadowcolor=elm.shadowcolor; 
        edge=elm.edge;
        edgecolor=elm.edgecolor; 
        
    //取得宽度
		setLayerWidth(name);
    
		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		drawSelect();
  }
  
 //---------------------------------------------------描绘---------------------------------------------------
	function setLayerWidth(str)
	{
		//取得宽度
		this.width=this.font.getTextWidth(str);
		this.height=this.font.getTextHeight(str)+5;
	}

  function drawSelect()
  {

    this.name=name;
    this.flagname=flagname;

	//默认字体
    if (fontname!=void) this.font.face=fontname;
	else this.font.face=f.setting.font.face;

    this.font.height=size;
    this.font.bold=bold;

    //取得宽度
	setLayerWidth(name);
    
    fillRect(0,0,width,height,0x00FFFFFF);
    
    if (shadow)
    {
      drawText(0,0, name, color,255,true,255,shadowcolor,0,2,2);
    }
    else if (edge)
    {
      drawText(0,0, name, color,255,true,255,edgecolor,1,0,0);
    }
    else
    {
      drawText(0, 0, name,color);
    }
	//描绘边框
	DrawSelectFrame();
  }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
        name=elm.name;
        left=elm.x;
        top=elm.y;
        flagname=elm.flagname;
        cond=elm.cond;
		lineheight=elm.lineheight;
     
        fontname=elm.fontname;
        size=elm.size;
        color=elm.color;
        bold=elm.bold;
        shadow=elm.shadow;
        shadowcolor=elm.shadowcolor; 
        edge=elm.edge;
        edgecolor=elm.edgecolor;
        
    this.drawSelect();
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
      dic.lineheight=this.lineheight;
      
      dic.fontname=this.fontname;      
      dic.size=this.size;
      dic.color=this.color;
      
      dic.bold=this.bold;
      dic.shadow=this.shadow;
      dic.shadowcolor=this.shadowcolor;
      dic.edge=this.edge;
      dic.edgecolor=this.edgecolor;

	dic.ctype="text";
      
      return dic;
      
 }
}
[endscript]
[return]
