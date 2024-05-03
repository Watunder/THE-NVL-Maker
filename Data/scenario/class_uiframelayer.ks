;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start

;-------------------------------------------------------------------------------------------
;姓名栏样式
;-------------------------------------------------------------------------------------------
[iscript]
class uiFrameLayer extends uiLayer
{

	var str;
	var color;
	var shadow;
	var shadowcolor;
	var edge;
	var edgecolor;
	var face;

	var textx;
	var texty;
	var textsize;
	var anchorc;

	function uiFrameLayer(str,elm)
	{
        super.Layer(kag, parent);

		this.str=str;
		Reset(elm);

		hitType = htMask;
		hitThreshold =0;
		focusable=true;
		drawSelect();
	}

	function drawSelect()
	{

		if (isPicExist(frame))
		{
		    this.loadImages(frame);
		}
		else
		{
		    this.loadImages("edit_button_close");
		}

		this.setSizeToImageSize();

		var tx = textx;
		var ty = texty;

		//居中描绘
		if (anchorc)
		{
			tx = (this.width-this.font.getTextWidth(str))/2;
			ty = (this.height-this.font.getTextHeight(str))/2;
		}

		//描绘文字

		if (edge)
		{
			drawText(tx,ty,str,color, 255, true, 255, edgecolor, 1, 0, 0);
		}
		else if (shadow)
		{
			drawText(tx,ty,str,color, 255, true, 255, shadowcolor, 0, 2, 2);
		}
		else
		{
			drawText(tx,ty,str,color,255,true);
		}

			//描绘边框
			DrawSelectFrame();
	}

	function Reset(elm)
	{
		//重置数值
		left=elm.left;
		top=elm.top;
		visible=elm.use;

		shadow=elm.shadow;
		shadowcolor=elm.shadowcolor;
		edge=elm.edge;
		edgecolor=elm.edgecolor;

		face=elm.face;
		color=(string)elm.color;

		font.height=elm.textsize;
		font.bold=elm.bold;
		font.italic=elm.italic;
		if (face!=void) font.face=face;
		else font.face=f.setting.font.face;

		frame=elm.frame;
		textx=elm.textx;
		texty=elm.texty;
		anchorc=elm.anchorc;

		drawSelect();
	}

	function LayerElm()
	{
		var dic=new Dictionary();
		//将该层的位置输出，供字典保存用
		dic.left=this.left;
		dic.top=this.top;
		dic.use=this.visible;

		//其他参数
		dic.shadow=this.shadow;
		dic.edge=this.edge;
		dic.shadowcolor=this.shadowcolor;
		dic.edgecolor=this.edgecolor;

		dic.face=this.face;
		dic.color=this.color;

		dic.textsize=this.font.height;
		dic.bold=this.font.bold;
		dic.italic=this.font.italic;

		dic.frame=this.frame;
		dic.textx=this.textx;
		dic.texty=this.texty;
		dic.anchorc=this.anchorc;
		
		return dic;
	}
}
[endscript]

[return]
