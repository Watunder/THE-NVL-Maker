;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.     
;-------------------------------------------------------------------------------------------
;---------------------------------------------------------------
;脚本编辑
;---------------------------------------------------------------
*start
[eval exp="drawPageBoard(143)"]
;---------------------------------------------------------------
[unlocklink]
[current layer="message1"]
[er]
;---------------------------------------------------------------
;有工程时，显示按钮(新建脚本、打开脚本)
[if exp="sf.project!=void"]
[frame title="脚本编辑" line=1 x=15 y=15]
[locate x=50 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*新建脚本]
[eval exp="drawButtonCaption('新建脚本')"]

[locate x=190 y=40]
[button normal="edit_button_normal" over="edit_button_over" on="edit_button_on" target=*打开脚本]
[eval exp="drawButtonCaption('打开脚本')"]

[frame title="多语言功能" line=3 x=15 y=95]


[frame title="素材管理" line=1 x=15 y=230]


[s]


*LOG转换
[iscript]
getTrpgLogBat();
[endscript]
[jump storage="script_main.ks"]


*新建脚本
;清空脚本名
[eval exp="tf.filename=void"]
[input name="tf.filename" title="新建脚本" prompt="请输入脚本文件名（不用扩展名）：        "]
;假如有输入脚本名，开始创建脚本
[iscript]
if (tf.filename!=void)
{
if (Storages.isExistentStorage(sf.path+"scenario/"+tf.filename+".story"))
{
   System.inform("哎呀呀~已经有同名脚本存在了~");
}
else
{
var content=[];
var path=Storages.getLocalName(sf.path+"scenario/"+tf.filename+".story");
//content[0]=";--------------------------------------------------";
//content[1]=";"+tf.filename+".story";
//content[2]=";--------------------------------------------------";
//content[3]="*start";
saveScript(path,content);
System.inform("脚本创建成功，可以打开编辑了","新建脚本");
}
}
[endscript]
[jump storage="script_main.ks"]

*打开脚本
[iscript]
f.scenario=void;
f.list=getsozai("story","scenario");
tf.当前编辑值="f.scenario";
[endscript]
[call storage="window_file.ks"]

;假如选择了文件，打开
[if exp="f.scenario!=void"]
[iscript]
//读入并解释
//extractScript();
System.shellExecute(Storages.getLocalName(sf.path+'scenario/')+f.scenario);
[endscript]
;[jump storage="gui_script.ks"]
[endif]

[jump storage="script_main.ks"]
