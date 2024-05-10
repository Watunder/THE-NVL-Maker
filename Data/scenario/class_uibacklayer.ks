;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.
;-------------------------------------------------------------------------------------------
*start
[iscript]
class uiBackLayer extends Layer
{
	var frame="edit_button_close";
	var stitle;
	var stitle_x;
	var stitle_y;

  //父层
  var parent=kag.fore.layers[4];

	function uiBackLayer(elm)
	{
     	super.Layer(kag, parent);

		left=0;
		top=0;

		absolute=1;

		visible=true;

		hitType = htMask;
		hitThreshold =0;

		focusable=false;
		Reset(elm);
	}

	function Reset(elm)
	{

		if (typeof elm == "String")
		{
			var bgdstr=elm;
			var dic=%["frame"=>bgdstr];
			elm=%[];
			(Dictionary.assign incontextof elm)(dic);
		}
		else
		{

		}

		frame=elm.frame;
		stitle=elm.stitle;
		stitle_x=elm.stitle_x;
		stitle_y=elm.stitle_y;

		//载入图片
		if (isPicExist(frame))
		{
		    this.loadImages(frame);
		}
		else
		{
		    this.loadImages("edit_button_close");
		}

		this.setSizeToImageSize();

		//附加小图片
		if (stitle!=void && isPicExist(stitle))
		{
			var slayer = new global.Layer(kag,this);
				slayer.loadImages(stitle);
				slayer.setSizeToImageSize();

			//复制小图片
			this.pileRect(stitle_x,stitle_y,slayer,0,0,slayer.width,slayer.height);
			delete slayer;
		}
	}

	function LayerElm()
	{
		var dic=%[];
		dic.frame=this.frame;
		dic.stitle=this.stitle;
		dic.stitle_x=this.stitle_x;
		dic.stitle_y=this.stitle_y;
		return dic;
	}
}
[endscript]
[return]
