;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
*start
;--------------------------------------------------------
;历史记录框
;--------------------------------------------------------
[iscript]

//简单描绘一行具有样式的文字
function drawUIText(layer,text,text_x,text_y,style,text_color)
{
	if (style.edge)
	{
	    layer.drawText(text_x,text_y,text,text_color,255,true,255,style.edgecolor,1,0,0);
	}
	else if (style.shadow)
	{
	    layer.drawText(text_x,text_y,text,text_color,255,true,255,style.shadowcolor,0,2,2);
	}
	else
	{
	    layer.drawText(text_x,text_y,text,text_color,255,true);
	}
}

function demoHistory()
{

	var layer=f.uibacklayer;
	var margin_dic=f.config_history;

     //描绘边框
     var x1=margin_dic.marginl;
     var x2=layer.width-margin_dic.marginr;
     var y1=margin_dic.margint;
     var y2=layer.height-margin_dic.marginb;
    
     var width=x2-x1;
     var height=y2-y1;

     layer.fillRect(x1,y1,width,1,0xCCFFFFFF);
     layer.fillRect(x1,y2,width,1,0xCCFFFFFF);
     layer.fillRect(x1,y1,1,height,0xCCFFFFFF);
     layer.fillRect(x2,y1,1,height,0xCCFFFFFF);
     
    var text_x=x1+5;
    var text_y=y1+5;

    //默认字体
	layer.font.face=f.setting.history.face;
    //字体大小
    layer.font.height=f.setting.history.size;
	layer.font.bold=f.setting.history.bold;

	var dic=f.setting.font;
	var text_color=dic.color;

    var text=getTransStr("文字显示范围");

	drawUIText(layer,text,text_x,text_y,dic,text_color);

}
[endscript]
;--------------------------------------------------------
;检查图片是否存在
;--------------------------------------------------------
[iscript]
function isPicExist(file)
{
	return (Storages.isExistentStorage(file+".jpg") || Storages.isExistentStorage(file+".png"));
}
[endscript]

[return]
