;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;常用控件组
;------------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;带有hint的按钮和button
;---------------------------------------------------------------
[macro name="hlink"]
[link * hint=&"getTransStr(mp.hint)"]
[endmacro]
[macro name="hbutton"]
[button * hint=&"getTransStr(mp.hint)"]
[endmacro]
;---------------------------------------------------------------
;指令按钮
;---------------------------------------------------------------
[macro name=button_tag]
[locate x=%x y=%y]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target="*打开指令窗口" exp=%exp]
[eval exp="drawButtonCaption(mp.name)"]
[endmacro]

;---------------------------------------------------------------
;滚动条/翻页按钮
;---------------------------------------------------------------
[macro name=button_page]
[locate x=%x y=%y]
[button normal=edit_slider_up exp="page_up(1)" interval=150 ontimer="page_up(1)"]
[locate x=%x y=&"(int)mp.y+(int)mp.length-16"]
[button normal=edit_slider_down exp="page_down(-1)" interval=150 ontimer="page_down(-1)"]
[endmacro]

[macro name=button_slider]
[locate x=%x y=%y]
[button normal="%normal|edit_slider_back2" interval=10 ontimer="page_scroll()"]
[endmacro]
;---------------------------------------------------------------
;确定取消按钮
;---------------------------------------------------------------
[macro name="uni_okcancel"]
[locate x=&"mp.width-23" y=6]
[button normal=edit_slider_button target=*关闭选单]
[eval exp="drawButtonCaption('×')"]
[locate x=&"mp.width-140" y=&"mp.height-80"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认')"]
[locate x=&"mp.width-140" y=&"mp.height-50"]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消')"]
[endmacro]
;---------------------------------------------------------------
;下层窗口背景
;---------------------------------------------------------------
[macro name=window_down]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[3],kag.fore.messages[3],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message3"]
[er]
[nowait]

[uni_okcancel width=&mp.width height=&mp.height]
[endmacro]
;---------------------------------------------------------------
;中层窗口背景
;---------------------------------------------------------------
[macro name=window_middle]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[5],kag.fore.messages[5],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message5"]
[er]
[nowait]

[uni_okcancel width=&mp.width height=&mp.height]
[endmacro]
;---------------------------------------------------------------
;最上层窗口背景
;---------------------------------------------------------------
[macro name=window_up]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[7],kag.fore.messages[7],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message7"]
[er]
[nowait]

[uni_okcancel width=&mp.width height=&mp.height]
[endmacro]
;---------------------------------------------------------------
;特别设定（图片窗口专用）
;---------------------------------------------------------------
[macro name=window_up_sp]
[locklink]
[rclick enabled=true jump=true call="false" target=*关闭选单]
;描绘窗体底板
[eval exp="drawWin(kag.fore.layers[7],kag.fore.messages[7],mp.title,mp.width,mp.height)"]
;描绘关闭按钮
[current layer="message7"]
[er]
[nowait]
[locate x=&"mp.width-23" y=6]
[button normal=close-square-outline target=*关闭选单]
;[eval exp="drawButtonCaption('×')"]
[locate x=93 y=40]
[emb exp="getTransStr('点三角形切换素材文件夹')"]
[locate x=320 y=40]
[emb exp="getTransStr('提示：新加入的素材在预览图中找不到的情况，请“重载工程”后再试')"]
[locate x=&"mp.width-260" y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*确认]
[eval exp="drawButtonCaption('确认')"]
[locate x=&"mp.width-140" y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*关闭选单]
[eval exp="drawButtonCaption('取消')"]
[endmacro]
;---------------------------------------------------------------
;标题框
;---------------------------------------------------------------
[macro name=frame]
[eval exp="drawFrame(mp.title,(int)mp.line,(int)mp.x,(int)mp.y)"]
[endmacro]
;---------------------------------------------------------------
;行[type=color/font/music/sound/script/cursor/cond][type=pic附带path/dw/dh]
;---------------------------------------------------------------
[macro name=line]
[eval exp="drawEdit(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.length,mp.true)"]
;附加框1
[if exp="mp.type!=void && mp.type!='pic' && mp.type!='list'"]
[eval exp="drawLink_Win(mp.name,mp.type)"]
[endif]
;图片附加框
[if exp="mp.type=='pic'"]
[eval exp="drawLink_Picwin(mp.name,mp.path,mp.dw,mp.dh)"]
[endif]
;下拉附加框
[if exp="mp.type=='list'"]
[eval exp="drawLink_List(mp.target)"]
[endif]
;附加框2
[if exp="mp.copyfrom!=void"]
 [hlink target=*window exp=&"mp.name+'=copy(\''+mp.copyfrom+'\')'" hint="点此复制上一栏内容"]
〇
[endlink]
[endif]
[endmacro]
;---------------------------------------------------------------
;单选框
;---------------------------------------------------------------
[macro name=check]
[eval exp="drawCheck(mp.title,mp.name,(int)mp.x,(int)mp.y)"]
[endmacro]
;---------------------------------------------------------------
;互斥选框
;---------------------------------------------------------------
[macro name=option]
[eval exp="drawOption(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.false)"]
[endmacro]
;---------------------------------------------------------------
;互斥选框组
;---------------------------------------------------------------
[macro name=group]
[eval exp="drawGroup(mp.title,mp.name,(int)mp.x,(int)mp.y,mp.comp)"]
[endmacro]
;---------------------------------------------------------------
;位置联动框(值xy,位置xy,条件,当作范例的图)
;---------------------------------------------------------------
[macro name=pos]
[eval exp="drawPos(mp.valuex,mp.valuey,(int)mp.x,(int)mp.y,mp.true,mp.sample)"]
[endmacro]

;---------------------------------------------------------------
;method相关参数输入
;---------------------------------------------------------------
[macro name=frame_trans]

[line title="时间" name="f.参数.time" x=%x y=%y]
[line title="方式" name="f.参数.method" x=%x y=&"(int)mp.y+30" type="list" target="*切换方式"]

;使用rule
[if exp="f.参数.method=='universal'"]
[line title="遮片" name="f.参数.rule" x=%x y=&"(int)mp.y+60" type="pic" path="rule"]
;使用滚动
[elsif exp="f.参数.method=='scroll'"]
[line title="方向" name="f.参数.from" x=%x y=&"(int)mp.y+60" type="list" target="*卷动方向"]
[line title="背景" name="f.参数.stay" x=%x y=&"(int)mp.y+90" type="list" target="*背景停留"]
[endif]

[check title="可略过" name="f.参数.canskip" x=%x y=&"(int)mp.y+125"]

[endmacro]
;---------------------------------------------------------------
;下拉菜单
;---------------------------------------------------------------
[macro name=list]
[locklink]
[rclick enabled=true jump=true target="%target|*关闭下拉菜单"]
[position layer="%layer|message4" left=&"(int)kag.current.left+(int)mp.x+40" top=&"(int)kag.current.top+(int)mp.y+24"]
[position layer="%layer|message4" width=%width|225 height=&"mp.line*23" frame="" color="0xFFFFFF" opacity=255]
[layopt layer="%layer|message4" visible="true"]
[current layer="%layer|message4"]
[er]
[nowait]
[style align="center"]
[endmacro]

;---------------------------------------------------------------
;层选择下拉菜单
;---------------------------------------------------------------
[macro name="list_fglayer_part"]
[link target=*关闭下拉菜单 exp="f.参数.layer='0'"][emb exp="getTransStr('前景层')"]No.0[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='1'"][emb exp="getTransStr('前景层')"]No.1[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='2'"][emb exp="getTransStr('前景层')"]No.2[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='3'"][emb exp="getTransStr('前景层')"]No.3[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='4'"][emb exp="getTransStr('前景层')"]No.4[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='5'"][emb exp="getTransStr('前景层')"]No.5[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='6'"][emb exp="getTransStr('前景层')"]No.6[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='7'"][emb exp="getTransStr('前景层')"]No.7[endlink][r]
[endmacro]

[macro name=list_fglayer]
[commit]
[list x=%x y=%y line=9 layer="message6"]
[list_fglayer_part]
[link target=*关闭下拉菜单 exp="f.参数.layer='8'"][emb exp="getTransStr('头像层')"]No.8[endlink]
[endmacro]

[macro name=list_glayer]
[commit]
[list x=%x y=%y line=10 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.layer='all'"][emb exp="getTransStr('全部前景')"][endlink][r]
[list_fglayer_part]
[link target=*关闭下拉菜单 exp="f.参数.layer='8'"][emb exp="getTransStr('头像层')"]No.8[endlink]
[endmacro]

[macro name=list_layer]
[commit]
[list x=%x y=%y line=11 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.layer='stage'"][emb exp="getTransStr('背景层')"][endlink][r]
[list_fglayer_part]
[link target=*关闭下拉菜单 exp="f.参数.layer='8'"][emb exp="getTransStr('头像层')"]No.8[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='event'"][emb exp="getTransStr('特效层')"][endlink]
[endmacro]

[macro name=list_page]
[commit]
[list x=%x y=%y line=2 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.page='fore'"][emb exp="getTransStr('表页')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.page='back'"][emb exp="getTransStr('里页')"][endlink]
[endmacro]

[macro name=list_map]
[commit]
[list x=%x y=%y line=2 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.layer='11'"][emb exp="getTransStr('默认')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.layer='14'"][emb exp="getTransStr('系统')"][endlink]
[endmacro]
;---------------------------------------------------------------
;method相关效果下拉菜单
;---------------------------------------------------------------
[macro name=list_method]
[commit]
[list x=%x y=%y line=10 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.method='crossfade'"][emb exp="getTransStr('淡入')"]（crossfade）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='universal'"][emb exp="getTransStr('遮片')"]（universal）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='turn'"][emb exp="getTransStr('翻页')"]（turn）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='wave'"][emb exp="getTransStr('波纹')"]（wave）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='ripple'"][emb exp="getTransStr('水面')"]（ripple）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='scroll'"][emb exp="getTransStr('卷动')"]（scroll）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='mosaic'"][emb exp="getTransStr('马赛克')"]（mosaic）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='rotateswap'"][emb exp="getTransStr('旋转切换')"]（rotateswap）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='rotatezoom'"][emb exp="getTransStr('旋转缩放')"]（rotatezoom）[endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.method='rotatevanish'"][emb exp="getTransStr('旋转消失')"]（rotatevanish）[endlink]
[endmacro]

[macro name=list_from]
[commit]
[list x=%x y=%y line=4 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.from='left'"][emb exp="getTransStr('自左')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.from='right'"][emb exp="getTransStr('自右')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.from='top'"][emb exp="getTransStr('自上')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.from='bottom'"][emb exp="getTransStr('自下')"][endlink]
[endmacro]

[macro name=list_stay]
[commit]
[list x=%x y=%y line=3 layer="message6"]
[link target=*关闭下拉菜单 exp="f.参数.stay='nostay'"][emb exp="getTransStr('不停留')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.stay='stayback'"][emb exp="getTransStr('移走原图')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.stay='stayfore'"][emb exp="getTransStr('遮盖原图')"][endlink]
[endmacro]
;---------------------------------------------------------------
;加算相关效果下拉菜单
;---------------------------------------------------------------
[macro name=list_image_effect]
[link target=*关闭下拉菜单 exp="f.参数.mode='alpha'"][emb exp="getTransStr('一般透过（默认）')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='opaque'"][emb exp="getTransStr('完全不透过')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='addalpha'"][emb exp="getTransStr('加算透过')"][endlink][r]

[link target=*关闭下拉菜单 exp="f.参数.mode='psadd'"][emb exp="getTransStr('PS加算')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='pssub'"][emb exp="getTransStr('PS減算')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='psmul'"][emb exp="getTransStr('PS正片叠底')"][endlink][r]

[link target=*关闭下拉菜单 exp="f.参数.mode='psscreen'"][emb exp="getTransStr('PS屏幕')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='psoverlay'"][emb exp="getTransStr('PS叠加')"][endlink][r]

[link target=*关闭下拉菜单 exp="f.参数.mode='pshlight'"][emb exp="getTransStr('PS强光')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='psslight'"][emb exp="getTransStr('PS柔光')"][endlink][r]

[link target=*关闭下拉菜单 exp="f.参数.mode='psdodge'"][emb exp="getTransStr('PS减淡')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='psburn'"][emb exp="getTransStr('PS加深')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='pslighten'"][emb exp="getTransStr('PS变亮')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='psdarken'"][emb exp="getTransStr('PS变暗')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='psdiff'"][emb exp="getTransStr('PS差值')"][endlink][r]
[link target=*关闭下拉菜单 exp="f.参数.mode='psexcl'"][emb exp="getTransStr('PS排除')"][endlink]
[endmacro]

[macro name=list_image_thumlist]
[list x=46 y=40 line=8 layer="message8" width=188]
[link exp="(f.bgimage=loadpic('bgimage') if f.bgimage==void),(f.list=f.bgimage)" target=*关闭下拉菜单][emb exp="getTransStr('背景')"](bgimage)[endlink][r]
[link exp="(f.fgimage=loadpic('fgimage') if f.fgimage==void),(f.list=f.fgimage)" target=*关闭下拉菜单][emb exp="getTransStr('前景')"](fgimage)[endlink][r]
[link exp="(f.rule=loadpic('rule') if f.rule==void),(f.list=f.rule)" target=*关闭下拉菜单][emb exp="getTransStr('遮片')"](rule)[endlink][r]
[link exp="(f.face=loadpic('face') if f.face==void),(f.list=f.face)" target=*关闭下拉菜单][emb exp="getTransStr('头像')"](face)[endlink][r]
[link exp="(f.image=loadpic('image') if f.image==void),(f.list=f.image)" target=*关闭下拉菜单][emb exp="getTransStr('图片')"](image)[endlink][r]
[link exp="(f.others=loadpic('others') if f.others==void),(f.list=f.others)" target=*关闭下拉菜单][emb exp="getTransStr('其他')"](other)[endlink][r]
[link exp="(f.map=loadpic('map') if f.map==void),(f.list=f.map)" target=*关闭下拉菜单][emb exp="getTransStr('地图')"](map)[endlink][r]
[link exp="(f.ui=loadpic('ui') if f.ui==void),(f.list=f.ui)" target=*关闭下拉菜单][emb exp="getTransStr('界面')"](ui)[endlink]
[endmacro]
;---------------------------------------------------------------
[return]
