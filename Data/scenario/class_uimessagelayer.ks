;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;--------------------------------------------------------------------------------------------------------------
;带有margin数据输出的对话框层
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiMessageLayer extends uiLayer
{
var marginl;
var marginr;
var margint;
var marginb;

var type="message";

  //---------------------------------------------------创建---------------------------------------------------
  function uiMessageLayer(elm)
  {
    super.uiLayer(elm);

    this.marginl=elm.marginl;
    this.marginr=elm.marginr;
    this.margint=elm.margint;
    this.marginb=elm.marginb;

	this.drawSelect();

  }

	function drawSelect()
	{
		super.drawSelect();
		this.drawMargin();
	}
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
    this.marginl=elm.marginl;
    this.marginr=elm.marginr;
    this.margint=elm.margint;
    this.marginb=elm.marginb;
    this.left=elm.left;
    this.top=elm.top;
    this.frame=elm.frame;

    this.drawSelect();
   }
	//描绘文字显示范围
	function drawMargin()
	{
		fillRect(marginl,margint,1,height-margint-marginb,0xFFFFFF);
		fillRect(width-marginr,margint,1,height-margint-marginb,0xFFFFFF);
		fillRect(marginl,margint,width-marginl-marginr,1,0xFFFFFF);
		fillRect(marginl,height-marginb,width-marginl-marginr,1,0xFFFFFF);

		//取得字体字号
		font.height=f.setting.font.size;
		font.face=f.setting.font.face;

		//翻译
		var text=getTransStr("文字显示范围");

		//drawText((int)marginl+(int)1,(int)margint+(int)1,text,0xFFFFFF,255,true);


		if (f.setting.font.edge)
		{
			drawText((int)marginl+(int)1,(int)margint+(int)1,text,f.setting.font.color, 255, true, 255, f.setting.font.edgecolor, 1, 0, 0);
		}
		else if (f.setting.font.shadow)
		{
			drawText((int)marginl+(int)1,(int)margint+(int)1,text,f.setting.font.color,255, true, 255, f.setting.font.shadowcolor, 0, 2, 2);
		}
		else
		{
			drawText((int)marginl+(int)1,(int)margint+(int)1,text,f.setting.font.color,255,true);
		}

	}
   //---------------------------------------------------输出---------------------------------------------------
   function MessageElm()
   {
      var dic=new Dictionary();
      //将该层的各数据输出，供字典保存用
      dic.frame=this.frame;
      dic.left=this.left;
      dic.top=this.top;
      dic.marginl=this.marginl;
      dic.marginr=this.marginr;
      dic.margint=this.margint;
      dic.marginb=this.marginb;

      dic.type=this.type;

      return dic;
   }
}
[endscript]
[return]
