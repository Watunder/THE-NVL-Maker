;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;文字样式设定
;--------------------------------------------------
*window
[window_middle width=400 height=390 title="文字样式"]

[check title="加粗" name="f.参数.bold" x=30 y=50]
[check title="斜体" name="f.参数.italic" x=130 y=50]

[option title="阴影" name="f.参数.shadow" x=30 y=80 false="f.参数.edge"]
[line title="" name="f.参数.shadowcolor" type="color" x=80 y=80 true="f.参数.shadow" length=174]
[option title="边缘" name="f.参数.edge" x=30 y=110 false="f.参数.shadow"]
[line title="" name="f.参数.edgecolor" type="color" x=80 y=110 true="f.参数.edge" length=174]

[line title="字体" name="f.参数.face" x=30 y=170 type="font"]
[line title="颜色" name="f.参数.color" type="color" x=30 y=200]
[line title="字号" name="f.参数.textsize" x=30 y=230]
;[line title="限宽" name="f.参数.textwidth" x=30 y=260]
[s]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择字体
[call storage="window_font.ks"]
[jump target=*window]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
