;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;--------------------------------------------------
;历史记录文字样式设定
;--------------------------------------------------
*window
[window_middle width=400 height=450 title="文字样式"]

;[check title="加粗" name="f.参数.bold" x=30 y=50]
;[check title="斜体" name="f.参数.italic" x=130 y=50]

[iscript]
drawFrame("样式",2,15,40,kag.fore.layers[5],314);
[endscript]
[option title="阴影" name="f.参数.shadow" x=30 y=60 false="f.参数.edge"]
[line title="" name="f.参数.shadowcolor" type="color" x=80 y=60 true="f.参数.shadow" length=174]
[option title="边缘" name="f.参数.edge" x=30 y=90 false="f.参数.shadow"]
[line title="" name="f.参数.edgecolor" type="color" x=80 y=90 true="f.参数.edge" length=174]

;[line title="字体文件" name="f.参数.face" x=30 y=140]
[iscript]
drawFrame("颜色",2,15,145,kag.fore.layers[5],314);
[endscript]
[line title="一般" name="f.参数.color" type="color" x=30 y=165]
[line title="选中" name="f.参数.selcolor" type="color" x=30 y=195]
;[line title="字号" name="f.参数.textsize" x=30 y=230]
;[line title="行间距" name="f.参数.linespace" x=30 y=260]

[iscript]
drawFrame("语音图标",2,15,250,kag.fore.layers[5],314);
[endscript]

[line title="一般" name="f.参数.icon" type="pic" x=30 y=265 path="ui"]
[line title="选中" name="f.参数.selicon" type="pic" x=30 y=295 path="ui" copyfrom="f.参数.icon"]
[s]

*选择字体
[call storage="window_font.ks"]
[jump target=*window]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*确认
[commit]

*关闭选单
[freeimage layer="5"]
[current layer="message5"]
[er]
[layopt layer="message5" visible="false"]
[return]
