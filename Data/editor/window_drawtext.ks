;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;文字size设定
;--------------------------------------------------
*window
[window_middle width=400 height=300 title="悬停文字设定"]
[pos valuex="f.参数.left" valuey="f.参数.top" x=30 y=50]
[line title="字号" name="f.参数.size" x=30 y=110]
[s]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
