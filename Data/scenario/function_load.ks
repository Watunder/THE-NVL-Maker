;-------------------------------------------------------------------------------------------
;    THE NVL Maker——GUI Editor for Kirikiri/KAG
;     Copyright (C) 2011  VariableD http://www.nvlmaker.net/

;     You should have received a copy of the GNU General Public License
;     along with this program.  If not, see <http://www.gnu.org/licenses/>.
;-------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------
;搜索及读入文件夹下的文件,缩略图列表
;-----------------------------------------------------------------------------------
[iscript]
//---------------------------------------------------------------
//读取某文件夹下文件名
//---------------------------------------------------------------
function getfile(path)
{
	try
	{
	  var list = getDirList(Storages.getLocalName(sf.path+path+"/")+"/");
	  return list;
	}
	catch(e)
	{
		dm("素材文件夹"+path+"读取失败");
		return [];
	}

}
//---------------------------------------------------------------
//读取其他类文件名(连同扩展名)[类型，位置]
//---------------------------------------------------------------
function getsozai(type,path)
{
  var list=getfile(path);
  var file=[];
     for (var i=0;i<list.count;i++)
   {
      //取得扩展名
      var ext=Storages.extractStorageExt(list[i]);
      dm(ext);
      //根据不同类型，返回需求的文件全名
      switch (type)
      {
        //剧本档
        case "story":
             if (ext=='.story') file.add(list[i]);
             break;
		//标题画面
        case "title":
             if (ext=='.tjs' && list[i].indexOf("uititle")!=-1) file.add(list[i]);
             break;
        //鼠标
        case "cur":
             if (ext=='.cur') file.add(list[i]);
             if (ext=='.ani') file.add(list[i]);
             break;
       case "map":
             if (ext=='.map') file.add(list[i]);
             break;
       case "edu":
             if (ext=='.edu') file.add(list[i]);
             break;
       case "bgm":
             if (ext=='.opus') file.add(list[i]);
             if (ext=='.wav') file.add(list[i]);
             break;
       case "se":
             if (ext=='.opus') file.add(list[i]);
             if (ext=='.wav') file.add(list[i]);
             break;
       case "mv":
             if (ext=='.mpeg') file.add(list[i]);
             if (ext=='.wmv') file.add(list[i]);
             if (ext=='.avi') file.add(list[i]);
             break;

      }
   }
   file.sort('a');
   return file;
}
//---------------------------------------------------------------
//读取图片类文件名(不要扩展名)[位置]
//---------------------------------------------------------------
function getpic(path)
{
   var list=getfile(path);
   var file=[];
   for (var i=0;i<list.count;i++)
   {
      var ext=Storages.extractStorageExt(list[i]);
      dm(ext);
      //将图片读入
                 switch (ext)
            {
                case ".png":
                case ".jpg":
                case ".tlg":
                case ".bmp":
                case ".eri":
                file.add(Storages.chopStorageExt(list[i]));
                break;
           }
   }
   //按照文件名顺序排列图片
   file.sort('a');
   return file;
}
//---------------------------------------------------------------
//读入图片缩略图
//---------------------------------------------------------------
function loadpic(path)
{

     //描绘文件夹名
       with(kag.fore.event)
      {
         //文字
         .font.height=16;
         .fillRect(110,90,210,40,0xFFFFFFFF);
         .drawText(120,100,path+"文件夹读取完毕", 0x000000);
         .update();
       }

   var list=getpic(path);
   var files=[];

    //取得文件名及缩略图
      for (var i=0;i<list.count;i++)
   {
        files[i]=new Dictionary();
        files[i].name=list[i];
        files[i].layer=new Layer(kag, kag.fore.base);

        //临时图层
        var temp=new Layer(kag, kag.fore.base);
        temp.loadImages(sf.path+path+"/"+files[i].name);
        temp.setSizeToImageSize();

		var zw=temp.width;
        var zh=temp.height;

        //设定缩略图比例
        if ((zw > 240) && (temp.height/temp.width)<=0.75)
        {
            zw=240;
            zh=zw*temp.height/temp.width;
        }
        else if ((zh > 180) && (temp.height/temp.width)>0.75)
        {
            zh=180;
            zw=zh*temp.width/temp.height;
        }

       //将图片缩放复制到层上
       files[i].layer.width=240;
       files[i].layer.height=180;
       files[i].layer.stretchCopy(0, 0, zw, zh, temp, 0, 0, temp.width, temp.height, stNearest);
   }

   return files;
}
[endscript]
;-----------------------------------------------------------------------------------
;搜索及读入游戏工程
;-----------------------------------------------------------------------------------
[iscript]
//---------------------------------------------------------------
//检查工程合法性
//---------------------------------------------------------------
function checkUIFile(file,path)
{
	dm(path+file);
	if (Storages.isExistentStorage(path+file)) return true;
	else return false;
}

function checkProject(fold)
{
	//设定路径
	var path=System.exePath + "project/"+fold+"/copperlichtdata/nvl/";

	//文件列表
	var arr=["setting",
				"uisave","uiload","uislpos","uihistory","uioption","uititle","uimenu","namelist","uiyesno","uisel",
				"uicgmode","uiendmode","uibgmmode"
			];

   //所有配置文件是否存在
	for (var i=0;i<arr.count;i++)
	{
		if (checkUIFile(arr[i]+".tjs",path)==false) return false;
	}

   return true;
}
//---------------------------------------------------------------
//读取project文件夹下的游戏工程
//---------------------------------------------------------------
function getProject()
{
   var list = getDirList(Storages.getLocalName(System.exePath + "project/")+"/");
   f.project=[];
   f.title=[];
   for (var i=0;i<list.count;i++)
   {
      if (list[i].indexOf('/')!=-1 && list[i].charAt(0)!='.')
      {
         var fold=list[i].substring(0,list[i].length-1);
         var path=System.exePath + "project/"+fold+"/copperlichtdata/";
         if (checkProject(fold))
         {
            //添加工程文件夹名
            f.project.add(fold);
            //添加游戏名
            var setting=Scripts.evalStorage(path+"nvl/"+'setting.tjs');
            f.title.add(setting.title);
         }
      }
   }

//计算页数
countPage(f.project.count,10);
}
//---------------------------------------------------------------
//读取游戏工程全设定
//---------------------------------------------------------------
function getConfig()
{


	//建立空白字典
	var setting=LoadDic('setting.tjs');

	//取得必要信息
	//读入Config.tjs
	var cont;
	cont=loadScript(sf.path+"nvl/"+"Config.tjs");

	for (var i=0;i<cont.count;i++)
	{
		//标题(可修改)
		if (cont[i].indexOf(";System.title")!=-1) setting.title=getConfigElm(cont[i]);

		//窗口大小(只读)
		if (cont[i].indexOf(";scWidth")!=-1) setting.width=(int)getConfigElm(cont[i]);
		if (cont[i].indexOf(";scHeight")!=-1) setting.height=(int)getConfigElm(cont[i]);

		//存档部分(只读)
		if (cont[i].indexOf(";numBookMarks")!=-1) setting.savedata.num=(int)getConfigElm(cont[i]);
		if (cont[i].indexOf(";thumbnailWidth")!=-1) setting.savedata.thumbnailwidth=(int)getConfigElm(cont[i]);

		//默认字体部分(只读)
		if (cont[i].indexOf(";userFace")!=-1) setting.font.face=getConfigElm(cont[i]);
		if (cont[i].indexOf(";defaultFontSize")!=-1) setting.font.size=(int)getConfigElm(cont[i]);
		if (cont[i].indexOf(";defaultChColor")!=-1) setting.font.color=getConfigElm(cont[i]);

		if (cont[i].indexOf(";defaultShadowColor")!=-1) setting.font.shadowcolor=getConfigElm(cont[i]);
		if (cont[i].indexOf(";defaultEdgeColor")!=-1) setting.font.edgecolor=getConfigElm(cont[i]);

		if (cont[i].indexOf(";defaultShadow")!=-1 && cont[i].indexOf(";defaultShadowColor")==-1) setting.font.shadow=getConfigElm(cont[i]);
		if (cont[i].indexOf(";defaultEdge")!=-1 && cont[i].indexOf(";defaultEdgeColor")==-1) setting.font.edge=getConfigElm(cont[i]);

		if (cont[i].indexOf(";global.useconfigMappfont")!=-1) setting.usemappfont=(int)getConfigElm(cont[i]);

		//历史记录部分(只读)
		if (cont[i].indexOf(";fontName")!=-1) setting.history.face=getConfigElm(cont[i]);
		if (cont[i].indexOf(";fontBold")!=-1) setting.history.bold=getConfigElm(cont[i]);
		if (cont[i].indexOf(";fontHeight")!=-1) setting.history.size=(int)getConfigElm(cont[i]);
		if (cont[i].indexOf(";lineHeight")!=-1) setting.history.linespace=(int)getConfigElm(cont[i]);

	}
	//返回信息
	return setting;

}

//取得一行内的信息
function getConfigElm(line)
{
	var arr=line.split(';',,true);
	var elm=arr[0].split("=",,true);

	var re = new RegExp("\"","g");
	elm[1]=elm[1].replace(re,"");

	if (elm[1]=="true") return 1;
	else if (elm[1]=="false") return 0;

	return elm[1].trim();
}

//---------------------------------------------------------------
//读取游戏工程全设定
//---------------------------------------------------------------
function getSetting()
{
	f.setting=getConfig();

	 //根据设定改变分辨率
	if (f.setting.width!=void) sf.gs.width=f.setting.width;
	if (f.setting.height!=void) sf.gs.height=f.setting.height;

	//确保大小正确
	if (sf.gs.width<800) sf.gs.width=800;
	if (sf.gs.height<720) sf.gs.height=720;

	//读取界面参数相关字典
	loadUIData();
}

//---------------------------------------------------------------
//读取界面参数相关字典
//---------------------------------------------------------------
function loadUIData()
{
	f.config_dia=LoadDic('uidia.tjs');
	f.config_option=LoadDic("uioption.tjs");
	f.config_history=LoadDic("uihistory.tjs");
	f.config_slpos=LoadDic("uislpos.tjs");
	f.config_save=LoadDic("uisave.tjs");
	f.config_load=LoadDic("uiload.tjs");
	f.config_title=LoadDic("uititle.tjs");
	f.config_menu=LoadDic("uimenu.tjs");
	f.config_name=LoadDic("namelist.tjs");
	f.config_cgmode=LoadDic('uicgmode.tjs');
	f.config_endmode=LoadDic('uiendmode.tjs');
	f.config_bgmmode=LoadDic('uibgmmode.tjs');
	f.config_yesno=LoadDic('uiyesno.tjs');
	f.config_sel=LoadDic('uisel.tjs');
	f.config_title_omake=LoadDic("uititle_omake.tjs");
	f.config_map=LoadDic('omake.map');
}
[endscript]
;-----------------------------------------------------------------------------------
;自动路径
;-----------------------------------------------------------------------------------
[iscript]
function ProjectAutoPath(path)
{
	var fullpath=sf.path+path+"/";
	Storages.addAutoPath(fullpath);
}

function ProjectRemoveAutoPath(path)
{
	var fullpath=sf.path+path+"/";
	Storages.removeAutoPath(fullpath);
}
[endscript]
;-----------------------------------------------------------------------------------
;自动路径
;-----------------------------------------------------------------------------------
[iscript]
function AddPath()
{
	//添加自动路径
	var arr=["bgimage","fgimage","rule","face","image","others","bgm","sound","voice","video","map","ui"];

	for (var i=0;i<arr.count;i++)
	{
		ProjectAutoPath(arr[i]);
	}
}

function RemovePath()
{
	//添加自动路径
	var arr=["bgimage","fgimage","rule","face","image","others","bgm","sound","voice","video","map","ui"];

	for (var i=0;i<arr.count;i++)
	{
		ProjectRemoveAutoPath(arr[i]);
	}
}
[endscript]
;-----------------------------------------------------------------------------------
[return]
