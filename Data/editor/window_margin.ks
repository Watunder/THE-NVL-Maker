;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;对话框页边距设定,margin
;--------------------------------------------------
*window
[window_up width=&"sf.gs.width+200" height=&"sf.gs.height+100" title="页边距设定"]
[iscript]
//背景设定
with(kag.fore.layers[8])
{
   .left=kag.fore.layers[7].left+20;
   .top=kag.fore.layers[7].top+50;
   .width=sf.gs.width;
   .height=sf.gs.height;
   .visible=true;
   .fillRect(0,0,sf.gs.width,sf.gs.height,0xFFC8C8C8);
}

drawFrame("页边距",3,sf.gs.width+40,50,kag.fore.layers[7],140);
kag.fore.layers[7].drawText(20,sf.gs.height+65,"提示：请以左上角->右下角的方向用鼠标拖动出红色框线，红框代表文字在对话框上显示的范围",0x000000);
f.marginlayer=new getMarginLayer(f.参数.frame);

[endscript]
[s]

*确认
[iscript]
//确认输出(正式写入f.参数.margin)
f.marginlayer.MarginElm();
[endscript]

*关闭选单
[iscript]
delete f.marginlayer;
[endscript]
[rclick enabled="false"]
[freeimage layer="7"]
[freeimage layer="8"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
