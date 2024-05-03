;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;文字范围设定
;x,y,行数,行间距
;--------------------------------------------------
*window
[window_middle width=400 height=370 title="悬停对话设定"]
[iscript]
drawFrame("文字设定",3,15,40,kag.fore.layers[5],314);
drawFrame("坐标",2,15,175,kag.fore.layers[5],314);
[endscript]
[line title="字号" name="f.参数.size" x=30 y=60]
[line title="行间距" name="f.参数.space" x=30 y=90]
[line title="每行字数" name="f.参数.count" x=30 y=120]

[pos valuex="f.参数.left" valuey="f.参数.top" x=30 y=195]
[s]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
