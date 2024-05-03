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
class uiMapButtonLayer extends uiButtonLayer
{

	var place;
	var storage;
	var target;
	var cond;
	var exp;

	var onenter;
	var onleave;

	var btntype;

  //---------------------------------------------------创建---------------------------------------------------
  function uiMapButtonLayer(elm)
  {
     	super.Layer(kag, parent);

		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		//描绘
		visible=elm.use;
		Reset(elm);
  }
   //---------------------------------------------------输出---------------------------------------------------
   function ButtonElm()
   {
		var dic=super.ButtonElm();

		dic.place=this.place;
		dic.storage=this.storage;
		dic.target=this.target;
		dic.cond=this.cond;
		dic.exp=this.exp;

		dic.onenter=this.onenter;
		dic.onleave=this.onleave;

		dic.btntype=this.btntype;

      	return dic;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
	    this.place=elm.place;
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
