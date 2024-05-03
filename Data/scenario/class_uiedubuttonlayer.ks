;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;--------------------------------------------------------------------------------------------------------------
;带悬停效果的地图按钮层,输出x,y,normal,over,on,use(visible),place,storage,target,cond
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiEduButtonLayer extends uiButtonLayer
{

	var name;
	var storage;
	var target;
	var cond;
	var exp;

	var onenter;
	var onleave;

	var btntype;
	var ctype="btn";

  //---------------------------------------------------创建---------------------------------------------------
  function uiEduButtonLayer(elm)
  {
     	super.Layer(kag, parent);

		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		//描绘
		visible=elm.use;
		Reset(elm);
  }
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
   //---------------------------------------------------输出---------------------------------------------------
   function LayerElm()
   {
		var dic=super.ButtonElm();
		//将该层的各数据输出，供字典保存用
		
		dic.name=this.name;
		dic.storage=this.storage;
		dic.target=this.target;
		dic.cond=this.cond;
		dic.exp=this.exp;
		
		dic.onenter=this.onenter;
		dic.onleave=this.onleave;
		
		dic.btntype=this.btntype;
		dic.ctype="btn";
		
		return dic;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
		this.name=elm.name;
		this.storage=elm.storage;
		this.target=elm.target;
		this.cond=elm.cond;
		this.exp=elm.exp;
		
		this.onenter=elm.onenter;
		this.onleave=elm.onleave;
		
		this.btntype=elm.btntype;
		
		super.Reset(...);
   }
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
