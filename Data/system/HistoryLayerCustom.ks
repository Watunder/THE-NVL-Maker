;// HistoryLayerCustom.ks - 支持一定程度的外观定制的HistoryLayer扩展模块
;// 作者：希德船长 修改、发布自由
;// 适用于KAG3 3.28

[if exp=" 'undefined' == typeof global.HistoryLayerCustom" ]
[iscript]

class HistoryLayerCustom extends HistoryLayerExtended
{
	var historyLayerType = "scroll"; // 默认显示模式为scroll模式(即HistoryLayerExtended的模式)
	
	function HistoryLayerCustom(win, par, direction, type)
	{
		super.HistoryLayerExtended(win, par, direction);
		
		if(type !== void)
			historyLayerType = type;

		if(historyLayerType == "default")
			controlHeight = 20;
	}
	
	function finalize()
	{
		super.finalize(...);
	}
	
	function setOptions(elm)
	{
		super.setOptions(elm);
		
		if(elm.type !== void)
			historyLayerType = elm.type;
	}
	
	function makeButtons()
	{
		if(historyLayerType == "default")
		{
			(global.HistoryLayer.makeButtons incontextof this)();
		}
		else
		{
			super.makeButtons();
		}
	}
	
	function updateButtonState()
	{
		if(historyLayerType == "default")
		{
			(global.HistoryLayer.updateButtonState incontextof this)();
		}
		else
		{
			super.updateButtonState();
		}
	}
}

kag.tagHandlers.history = function(elm)
{
	if(!(historyLayer instanceof "HistoryLayerCustom"))
	{
		remove(historyLayer);
		invalidate historyLayer if historyLayer !== void;
		historyLayer = new HistoryLayerCustom(this, fore.base, elm.direction, elm.type);
		add(historyLayer);
	}

	setHistoryOptions(elm);
	return 0;
} incontextof kag;

[endscript]
[endif]
[return]