;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;姓名编辑
;f.config_name的编辑

;单个内容:
;姓名(宏的名字)
;显示名
;颜色1
;颜色2

;新增姓名
;删除姓名
;保存
;重载
;---------------------------------------------------------------
*start
*window
[eval exp="drawPageBoard(214)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
[frame title="默认姓名颜色" line=2 x=15 y=15]
[line title=&"f.config_name[0].name" x=30 y=40]
[line title=&"f.config_name[0].name" name="f.config_name[0].color" x=30 y=40 type="color"]
[line title=&"f.config_name[1].name" name="f.config_name[1].color" x=30 y=70 type="color"]

[frame title="新增姓名" line=5 x=15 y=125]
[line title="简称" name="f.name_tag" x=30 y=150]
[line title="姓名" name="f.name_name" x=30 y=180]
[line title="颜色" name="f.name_color" x=30 y=210 type="color"]
[line title="头像" name="f.name_face" x=30 y=240 type="pic" path="face"]

[locate x=190 y=280]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新增姓名]
[eval exp="drawButtonCaption('新增姓名')"]

[frame title="记录" line=1 x=15 y=325]
[locate x=50 y=345]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*保存并生成宏]
[eval exp="drawButtonCaption('保存并生成宏')"]
[locate x=190 y=345]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*放弃全部修改]
[eval exp="drawButtonCaption('放弃全部修改')"]

[frame title="既有姓名编辑" line=20 x=345 y=15]
[frame title="既有姓名编辑" line=20 x=675 y=15]
[frame title="既有姓名编辑" line=20 x=1005 y=15]
;姓名
;编辑
;删除
[iscript]
for (var i=2;i<f.config_name.count;i++)
{
//姓名
//姓名
if (i<=21)
{
   drawEdit(f.config_name[i].tag,,360,40+(i-2)*30);
}
else if (i<=41)
{
   drawEdit(f.config_name[i].tag,,690,40+(i-22)*30);
}
else
{
   drawEdit(f.config_name[i].tag,,1020,40+(i-42)*30);
}
//drawEdit(f.config_name[i].tag,,360,40+(i-2)*30);
//编辑
drawLink_Win("f.config_name["+i+"]","name");
//删除
   kag.tagHandlers.ch(%["text"=>"  "]);
   var setting=new Dictionary();
   setting.exp="kag.current.commit(),tf.当前编辑值="+i;
   setting.target="*删除姓名";
   kag.tagHandlers.link(setting);
   kag.tagHandlers.ch(%["text"=>getTransStr("删除")]);
   kag.tagHandlers.endlink(%[]);
}
[endscript]
[s]

*选择颜色
[call storage="window_color.ks"]
[jump target=*window]

*新增姓名
[commit]
[iscript]
if (f.config_name.count<62)
{
      //假如值不为空，在姓名串里增加
    if (f.name_tag!=void && f.name_name!=void && f.name_color!=void)
    {
      f.config_name.add(%["tag"=>f.name_tag,"name"=>f.name_name,"color"=>f.name_color]);
      //消除文字
      f.name_tag=void;
      f.name_name=void;
      f.name_color=void;
     }
}
else
{
System.inform("喂喂，真的有这么多人吗，显示不下了啦~","囧");
}
[endscript]
[jump target=*window]


*选择图片
[call storage="window_picture.ks"]
[jump target=*window]

*编辑姓名
[call storage="window_name.ks"]
[jump target=*window]

*删除姓名
[iscript]
f.config_name.erase(tf.当前编辑值);
[endscript]
[jump target=*window]

*保存并生成宏
[commit]

[iscript]
function SaveNameList()
{
	//进行保存
	var folder=sf.path+"nvl/";

	f.config_name.saveStruct(folder+"namelist.tjs");
	
	var arr=[];

	//自动生成宏
	f.文件=[];
	f.文件[0]=";--------------------------------------------";
	f.文件[1]=";自动生成的人物姓名宏";
	f.文件[2]=";--------------------------------------------";
	f.文件[3]="*start";
	
	f.文件[4]="[macro name=主角]";
	f.文件[5]="[npc * id=主角]";
	f.文件[6]="[endmacro]";
	
	//生成宏脚本
	for (var i=2;i<f.config_name.count;i++)
	{
		f.文件.add("");
		f.文件.add(";--------------------------------------------");
		f.文件.add(";"+f.config_name[i].name);
		f.文件.add(";--------------------------------------------");
		f.文件.add("[macro name="+f.config_name[i].tag+"]");
		f.文件.add("[npc * id="+f.config_name[i].name+"]");
		//如果脚本里没有指定头像，自动添加头像
		if(f.config_name[i].face!=void) f.文件.add("[face storage="+f.config_name[i].face+" cond=\"mp.face==void\"]");
		f.文件.add("[endmacro]");

		arr.add(f.config_name[i].name);

	}
	
	f.文件.add(";--------------------------------------------");
	f.文件.add("[return]");
	
	//进行保存
	f.文件.save(folder+"macro_name.ks");
	arr.save(folder+"namelist.txt");
}

SaveNameList();

[endscript]

[jump target=*window]

*放弃全部修改
[iscript]
//重载
f.config_name=LoadDic("namelist.tjs");
[endscript]
[jump target=*window]
