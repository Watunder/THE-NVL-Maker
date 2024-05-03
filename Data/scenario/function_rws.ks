;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.
;-------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------
;音乐的播放函数
;------------------------------------------------------------------------------------------------
[iscript]
function bgmplayer(file,isloop=false)
{
	stopbgm();
	dm("音乐播放："+file+"，循环："+isloop);
	var ext=Storages.extractStorageExt(file);
	if (ext==".mid")
	kag.tagHandlers.playbgm(%[
	"storage"=>file,
	"loop"=>isloop
	]);
	else
	kag.tagHandlers.playse(%[
	"storage"=>file,
	"loop"=>isloop
	]);
}
function stopbgm()
{
	kag.tagHandlers.stopbgm(%[]);
	kag.tagHandlers.stopse(%[]);
}
[endscript]
;------------------------------------------------------------------------------------------------
;通用的文本文件的选择,载入,保存,重写
;------------------------------------------------------------------------------------------------
;------------------------------------------------------------------
;启动游戏
;------------------------------------------------------------------
[iscript]
function runGameTest()
{
	//System.shellExecute(Storages.getLocalName(System.exePath+'project/'+sf.project+'/') + 'krkr.exe');
}
[endscript]
;------------------------------------------------------------------
;启动打包工具
;------------------------------------------------------------------
[iscript]
function runPack()
{
	//System.shellExecute(Storages.getLocalName(System.exePath+"tool/") + "krkrrel.exe",'"project/'+sf.project+'/copperlichtdata"');
}
[endscript]
;------------------------------------------------------------------
;重写启动脚本
;------------------------------------------------------------------
[iscript]
function rewriteStart(storage)
{
//自动生成宏
var arr=[];
arr[0]=";--------------------------------------------";
arr[1]=";由编辑器自动改写以方便测试的跳转脚本";
arr[2]=";--------------------------------------------";
arr[3]="[jump storage=\""+storage+"\"]";

//进行保存
arr.save(sf.path+"nvl/"+"start.ks");
}
[endscript]

;------------------------------------------------------------------
;读入文本文件
;------------------------------------------------------------------
[iscript]
function loadScript(file)
{
var script=[];
script.load(file);
return script;
}
[endscript]
;------------------------------------------------------------------
;保存文本文件
;------------------------------------------------------------------
[iscript]
function saveScript(filename,script)
{
  Plugins.link("win32ole.dll");
  var objFileSystem = new WIN32OLE("Scripting.FileSystemObject");
  var objTextFile = objFileSystem.OpenTextFile(filename , 2 ,true ,-1);
  //参数:文件名,(只读1/只写2/续写8),不存在是否新建(true/false),(默认-2/UNICODE-1/ASCII0)
  for (var i=0;i<script.count;i++)
   {
       objTextFile.WriteLine(script[i]);
    }
objTextFile.Close();
}
[endscript]
;------------------------------------------------------------------
;保存设定文件
;------------------------------------------------------------------
[iscript]
function saveConfig()
{
//读入模板设定
var cont;
cont=loadScript(sf.path+"nvl/"+"Config.tjs");

	//按行改写部分内容
	for (var i=0;i<cont.count;i++)
	{
		//标题
		if (cont[i].indexOf(";System.title")!=-1)
		{
			cont[i]=";System.title = \""+f.setting.title+"\";";
			break;
		}
	}

	saveScript(Storages.getLocalName(sf.path+"Config.tjs"),cont);
}
[endscript]

;------------------------------------------------------------------
;简化代码用函数
;------------------------------------------------------------------
[iscript]
//复制字典
function CopyDic(dic)
{
	return dic;
}
//-----------------------------------------------------------------------
//保存界面数据字典
//-----------------------------------------------------------------------
function SaveDic(dic,file,folder="nvl")
{
	//保存
	(Dictionary.saveStruct incontextof dic)(sf.path+folder+"/"+file);
}
//-----------------------------------------------------------------------
//读取界面数据字典
//-----------------------------------------------------------------------
function LoadDic(file,folder="nvl")
{
	var fullfile=sf.path+folder+"/"+file;
	if (Storages.isExistentStorage(fullfile))
	{
		var dic=Scripts.evalStorage(fullfile);
		return dic;
	}
	else
	{
		return %[];
	}
}
//-----------------------------------------------------------------------
//返回界面文件完整路径
//-----------------------------------------------------------------------
function GetPath(file,folder="nvl")
{
	//System.inform(sf.path+folder+"/"+file);
	return sf.path+folder+"/"+file;
}
//-----------------------------------------------------------------------
//打开界面数据文件
//-----------------------------------------------------------------------
function OpenPath(file,folder)
{
	var path=GetPath(file,folder);
	//System.inform(path);
	System.shellExecute(Storages.getLocalName(path));
}
[endscript]

[return]
