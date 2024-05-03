*window
[window_middle width=700 height=370 title="文字栏样式设定"]
[iscript]
drawFrame("文字样式",9,15,40,kag.fore.layers[5],314);
drawFrame("显示设定",4,345,40,kag.fore.layers[5],314);
[endscript]
[check title="加粗" name="f.参数.bold" x=30 y=60]
[check title="斜体" name="f.参数.italic" x=130 y=60]

[option title="阴影" name="f.参数.shadow" x=30 y=90 false="f.参数.edge"]
[line title="" name="f.参数.shadowcolor" type="color" x=80 y=90 true="f.参数.shadow" length=174]
[option title="边缘" name="f.参数.edge" x=30 y=120 false="f.参数.shadow"]
[line title="" name="f.参数.edgecolor" type="color" x=80 y=120 true="f.参数.edge" length=174]

[line title="字体" name="f.参数.face" x=30 y=150 type="font"]
[line title="字号" name="f.参数.textsize" x=30 y=180]
[line title="颜色" name="f.参数.color" x=30 y=210 type=color]

[line title="x" name="f.参数.textx" x=30 y=240]
[line title="y" name="f.参数.texty" x=30 y=270]
[check title="自动居中" name="f.参数.anchorc" x=30 y=300]

[line title="底框" name="f.参数.frame" x=360 y=60 type="pic" path="others"]
[line title="x" name="f.参数.left" x=360 y=90]
[line title="y" name="f.参数.top" x=360 y=120]
[check title="使用" name="f.参数.use" x=360 y=150]
[s]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*选择图片
[call storage="window_picture.ks"]
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
