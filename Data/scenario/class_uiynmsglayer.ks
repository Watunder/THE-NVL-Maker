;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;-------------------------------------------------------------------------------------------
;消息文字样式
;-------------------------------------------------------------------------------------------
[iscript]

class uiYNMsgLayer extends uiLayer
{
	var str;
	var color;
	var shadow;
	var shadowcolor;
	var edge;
	var edgecolor;
	var face;
	var textwidth;
	var centerleft;
	var centertop;

	  function uiYNMsgLayer(str,elm)
  {
        super.Layer(kag, parent);

		this.str=str;
		visible=true;
		Reset(elm);

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		drawSelect();
  }

	//---------------------------------------------------描绘---------------------------------------------------
	function drawSelect()
	{

			//取得宽度
			width=this.font.getTextWidth(str);
			height=this.font.getTextHeight(str)+10;

			//取得中点坐标
			centerleft=(int)(this.left+width/2);
			centertop=(int)(this.top+height/2);

			fillRect(0,0,width,height,0x00FFFFFF);

			if (shadow)
			{
				drawText(0,0, str, color,255,true,255,shadowcolor,0,2,2);
			}
			else if (edge)
			{
				drawText(0,0, str, color,255,true,255,edgecolor,1,0,0);
			}
			else
			{
				drawText(0, 0, str,color);
			}

		      fillRect(width/2-5,height/2-1,10,1,0xCCFF0000);
		      fillRect(width/2-1,height/2-5,1,10,0xCCFF0000);

			//描绘边框
			DrawSelectFrame();
	}
 //---------------------------------------------------重置数值---------------------------------------------------
	function Reset(elm)
	{
		//重置数值
		left=elm.left;
		top=elm.top;

		shadow=elm.shadow;
		shadowcolor=elm.shadowcolor;
		edge=elm.edge;
		edgecolor=elm.edgecolor;
		textwidth=elm.textwidth;

		face=elm.face;
		color=(string)elm.color;

		font.height=elm.textsize;
		font.bold=elm.bold;
		font.italic=elm.italic;

		//默认字体
		if (face!=void) font.face=face;
		else font.face=f.setting.font.face;

	}
 //---------------------------------------------------输出---------------------------------------------------
 function TextElm()
 {
      var dic=new Dictionary();

      //将该层的位置输出，供字典保存用
		dic.left=this.left;
		dic.top=this.top;

		dic.centerleft=this.centerleft;
		dic.centertop=this.centertop;

		dic.shadow=this.shadow;
		dic.edge=this.edge;
		dic.shadowcolor=this.shadowcolor;
		dic.edgecolor=this.edgecolor;

		dic.face=this.face;
		dic.color=this.color;
		dic.textwidth=this.textwidth;

		dic.textsize=this.font.height;
		dic.bold=this.font.bold;
		dic.italic=this.font.italic;

      	return dic;
 }

}
[endscript]
[return]
