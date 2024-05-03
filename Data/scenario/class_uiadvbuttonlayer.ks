;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------
;带悬停效果的调查按钮层,输出x,y,width,height,use(visible),place,storage,target,cond
;--------------------------------------------------------------------------------------------------------------
[iscript]
class uiAdvButtonLayer extends uiMapButtonLayer
{
	var r_width;
	var r_height;

  //---------------------------------------------------创建---------------------------------------------------
  function uiAdvButtonLayer(elm)
  {
     	super.Layer(kag, parent);

		hitType = htMask;
		hitThreshold =0;
		focusable=true;

		//描绘
		visible=elm.use;
		Reset(elm);
  }
  //---------------------------------------------------描绘---------------------------------------------------
  function drawSelect(state=normal,stnum=0)
  {
		this.width=r_width;
		this.height=r_height;
	
		this.fillRect(0,0,r_width,r_height,0xCCFFFFFF);
	
		if (state!=void)
		{
			super.drawSelect(...);
		}
		else
		{
			//描绘辨识文字
			this.font.height=18;
			drawText(5,5,this.place,0xFF000000);
		    //假如选中,带边框
		    if (select)
		    {
		      fillRect(0,0,width,1,0xCCFF0000);
		      fillRect(0,0,1,height,0xCCFF0000);
		      fillRect(0,height-1,width,1,0xCCFF0000);
		      fillRect(width-1,0,1,height,0xCCFF0000);
		    }
		}
  }
   //---------------------------------------------------输出---------------------------------------------------
   function ButtonElm()
   {
		var dic=super.ButtonElm();
		//将该层的各数据输出，供字典保存用
		dic.width=this.width;
		dic.height=this.height;

      	return dic;
   }
   //----------------------------------根据传入参数重设层的值---------------------------------------------------
   function Reset(elm)
   {
	    this.r_width=elm.width;
	    this.r_height=elm.height;
		super.Reset(...);
   }
}
[endscript]

[return]
