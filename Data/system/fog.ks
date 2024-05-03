@if exp="typeof(global.fog_object) == 'undefined'"
@iscript

/*
	模拟雾气的插件

	这个是在下雪的插件的基础上修改的
*/

class FogGrain
{
	// 雾气团块的类

	var fore; // 表层的雾气团块的layer对象
	var back; // 裏层的雾气团块的layer对象
	var xvelo; // 横速度
	var yvelo; // 縦速度
	var xaccel; // 横加速
	var yaccel; // 縦加速
	var l, t; // 横位置と縦位置
	var ownwer; // このオブジェクトを所有する FogPlugin オブジェクト
	var spawned = false; // 雾气团块是否出现
	var window; // ウィンドウオブジェクトへの参照

	function FogGrain(window, n, opacity, owner)
	{
		// FogGrain コンストラクタ
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

		fore.absolute = 2000000-1; // 重ね合わせ順序はメッセージ履歴よりも奥
		back.absolute = fore.absolute;

		fore.hitType = htMask;
		fore.hitThreshold = 256; // マウスメッセージは全域透過
		back.hitType = htMask;
		back.hitThreshold = 256;

		fore.loadImages("fog_" + n); // 画像を読み込む
		back.assignImages(fore);
		fore.setSizeToImageSize(); // レイヤのサイズを画像のサイズと同じに
		back.setSizeToImageSize();
		fore.opacity = opacity; // 不透明度
		back.opacity = opacity;
		xvelo = 0; // 横方向速度
		yvelo = 0; // 縦方向速度
		xaccel = 0; // 初期加速度
		yaccel = 0;
	}

	function finalize()
	{
		invalidate fore;
		invalidate back;
	}

	function spawn()
	{
		// 出現
		l = Math.random() * window.primaryLayer.width; // 横初期位置
		t = Math.random() * window.primaryLayer.height; // 縦初期位置
		spawned = true;
		fore.setPos(l, t);
		back.setPos(l, t); // 裏画面の位置も同じに
		fore.visible = owner.foreVisible;
		back.visible = owner.backVisible;
	}

	function resetVisibleState()
	{
		// 表示?非表示の状態を再設定する
		if(spawned)
		{
			fore.visible = owner.foreVisible;
			back.visible = owner.backVisible;
		}
		else
		{
			fore.visible = false;
			back.visible = false;
		}
	}

	function move()
	{
		// 移动雾气团块
		l += xvelo;
		t += yvelo;
		xvelo += xaccel;
		xaccel += (Math.random() - 0.5) * 0.3;
		yvelo += yaccel;
		yaccel += (Math.random() - 0.5) * 0.3;
		if(xvelo>=1.5) xvelo=1.5;
		if(xvelo<=-1.5) xvelo=-1.5;
		if(xaccel>=0.2) xaccel=0.2;
		if(xaccel<=-0.2) xaccel=-0.2;
		if(yvelo>=1.5) yvelo=1.5;
		if(yvelo<=-1.5) yvelo=-1.5;
		if(yaccel>=0.2) yaccel=0.2;
		if(yaccel<=-0.2) yaccel=-0.2;
		if(l < -fore.width)
			l = -fore.width;
		if(t < -fore.height)
			t = -fore.height;
		if(l > window.primaryLayer.width)
			l = window.primaryLayer.width;
		if(t > window.primaryLayer.height)
			t = window.primaryLayer.height;

		fore.setPos(l, t);
		back.setPos(l, t); // 裏画面の位置も同じに
	}

	function exchangeForeBack()
	{
		// 表と裏の管理情報を交換する
		var tmp = fore;
		fore = back;
		back = tmp;
	}
}

class FogPlugin extends KAGPlugin
{
	var fogs = []; // 雾气团块
	var timer; // タイマ
	var window; // ウィンドウへの参照
	var foreVisible = true; // 表画面が表示状態かどうか
	var backVisible = true; // 裏画面が表示状態かどうか

	function FogPlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize メソッド
		// このクラスの管理するすべてのオブジェクトを明示的に破棄
		for(var i = 0; i < fogs.count; i++)
			invalidate fogs[i];
		invalidate fogs;

		invalidate timer if timer !== void;

		super.finalize(...);
	}

	function init(num, options)
	{
		if(timer !== void) return;


		for(var i = 0; i < num; i++)
		{
			var n = intrandom(0, 3); 
			fogs[i] = new FogGrain(window, n, +options.opacity, this);
			fogs[i].spawn();
		}

		// タイマーを作成
		timer = new Timer(onTimer, '');
		timer.interval = 80;
		timer.enabled = true;

		foreVisible = true;
		backVisible = true;
		setOptions(options); // オプションを設定
	}

	function uninit()
	{

		if(timer === void) return;

		for(var i = 0; i < fogs.count; i++)
			invalidate fogs[i];
		fogs.count = 0;

		invalidate timer;
		timer = void;
	}

	function setOptions(elm)
	{
		// オプションを設定する
		foreVisible = +elm.forevisible if elm.forevisible !== void;
		backVisible = +elm.backvisible if elm.backvisible !== void;
		resetVisibleState();
	}

	function onTimer()
	{
		// タイマーの周期ごとに呼ばれる
		var fogcount = fogs.count;
		for(var i = 0; i < fogcount; i++)
			fogs[i].move(); // move メソッドを呼び出す
	}

	function resetVisibleState()
	{
		var fogcount = fogs.count;
		for(var i = 0; i < fogcount; i++)
			fogs[i].resetVisibleState(); // resetVisibleState メソッドを呼び出す
	}

	function onStore(f, elm)
	{
		// 栞を保存するとき
		var dic = f.fogs = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.fogCount = fogs.count;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.fogs;
		if(dic === void || !+dic.init)
		{
			uninit();
		}
		else if(dic !== void && +dic.init)
		{
			init(dic.fogCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible ] );
		}
	}

	function onStableStateChanged(stable)
	{
	}

	function onMessageHiddenStateChanged(hidden)
	{
	}

	function onCopyLayer(toback)
	{
		// レイヤの表←→裏情報のコピー
		// このプラグインではコピーすべき情報は表示?非表示の情報だけ
		if(toback)
		{
			// 表→裏
			backVisible = foreVisible;
		}
		else
		{
			// 裏→表
			foreVisible = backVisible;
		}
		resetVisibleState();
	}

	function onExchangeForeBack()
	{
		// 裏と表の管理情報を交換
		var fogcount = fogs.count;
		for(var i = 0; i < fogcount; i++)
			fogs[i].exchangeForeBack(); // exchangeForeBack メソッドを呼び出す
	}
}

kag.addPlugin(global.fog_object = new FogPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

@endscript
@endif
; マクロ登録
@macro name="foginit"
@eval exp="mp.num=20" cond=(mp.num===void)
@eval exp="mp.opacity=255" cond=(mp.opacity===void)
@eval exp="fog_object.init(+mp.num, mp)"
@endmacro
@macro name="foguninit"
@eval exp="fog_object.uninit()"
@endmacro
@macro name="fogopt"
@eval exp="fog_object.setOptions(mp)"
@endmacro
@return

