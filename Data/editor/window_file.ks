;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------

;---------------------------------------------------------------
;.ks文件选择
;---------------------------------------------------------------
*window
[window_up width=450 height=450 title="选择文件"]
;滚动条
[image layer=9 storage="edit_slider_button" left=&"(int)kag.fore.layers[7].left+225"]
;翻页按钮
[button_page x=225 y=50 length=325]
;滚动条按钮
[button_slider x=225 y=66]
[iscript]
//计算页数
countPage(f.list.count,15);
//默认显示第一页
f.curpage=1;
//描绘box
f.window='file';
update();
//描绘按钮
drawButtonLine(20,74,"edit_button_line2",15,20);
[endscript]
[s]

*确认
[if exp="f.list[f.select]!=void"]
[eval exp=&"tf.当前编辑值+'=\''+f.list[f.select]+'\''"]
[endif]

*关闭选单
[eval exp="f.window=''"]
[rclick enabled="false"]
[freeimage layer="7"]
[freeimage layer="8"]
[freeimage layer="9"]
[current layer="message7"]
[er]
[layopt layer="message7" visible="false"]
[return]
