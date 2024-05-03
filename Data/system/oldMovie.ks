@if exp="typeof(global.oldMovie_object) == 'undefined'"
@iscript

/*
	古いフィルムのような効果をつけるプラグイン
*/

class OldMovie
{
	// フィルム効果のクラス

	var fore; // 表画面の効果オブジェクト
	var back; // 裏画面の効果オブジェクト
	var l, t; // 横位置と縦位置
	var ownwer; // このオブジェクトを所有するオブジェクト
	var spawned = false; // 効果が出現しているか
	var window; // ウィンドウオブジェクトへの参照
    var type; // 効果の種類。0は縦線、1はノイズ

	function OldMovie(window, tp, h, opa, opa2, owner)
	{
        var opac;

		// OldMovie コンストラクタ
		this.owner = owner;
		this.window = window;

		fore = new Layer(window, window.fore.base);
		back = new Layer(window, window.back.base);

		fore.hitType = htMask;
		fore.hitThreshold = 256; // マウスメッセージは全域透過
		back.hitType = htMask;
		back.hitThreshold = 256;
        fore.face = dfBoth;
        back.face = dfBoth;
        type = tp;
        if(type == 0) {
            fore.setSize(2, window.primaryLayer.height);
            back.setSize(2, window.primaryLayer.height);
            fore.fillRect(0, 0, 2, h, 0xFF000000);
    		opac = opa;
        }
        else {
            fore.setSize(1,1);
            back.setSize(1,1);
            fore.fillRect(0, 0, 1, 1, 0xFFFFFFFF);
    		opac = opa2;
        }
		back.assignImages(fore);
		fore.opacity = opac;
		back.opacity = opac;
        fore.parent = window.fore.base;
        back.parent = window.back.base;

		fore.absolute = 5000 - 1; // 重ね合わせ順序の指定
		back.absolute = fore.absolute;
	}

	function finalize()
	{
		invalidate fore;
		invalidate back;
	}

	function spawn(nl,nt,nw,nh)
	{
		// 出現
		l = Math.random() * nw; // 横初期位置
        var tt = nt;
        if(type == 1) tt += Math.random() * nh;
		spawned = true;
		fore.setPos(nl + l, tt);
		back.setPos(nl + l, tt); // 裏画面の位置も同じに
		fore.visible = owner.foreVisible;
		back.visible = owner.backVisible;
	}

	function resetVisibleState()
	{
		// 表示・非表示の状態を再設定する
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

	function move(nl,nt,nw,nh)
	{
		l = Math.random() * nw; // 横初期位置
        var tt = nt;
        if(type == 1) tt += Math.random() * nh;
		fore.setPos(nl + l, tt);
		back.setPos(nl + l, tt); // 裏画面の位置も同じに
	}

	function exchangeForeBack()
	{
		// 表と裏の管理情報を交換する
		var tmp = fore;
		fore = back;
		back = tmp;
	}
}

class OldMoviePlugin extends KAGPlugin
{
	// 効果をつけるプラグインクラス

	var noises = []; // 縦線
    var pnoises = []; // ノイズ
	var timer; // タイマ
	var window; // ウィンドウへの参照
	var foreVisible = true; // 表画面が表示状態かどうか
	var backVisible = true; // 裏画面が表示状態かどうか
	var l = 0; // 描画範囲 ( 指定可能 )
    var t = 0;
	var w; 
    var h;
    var opa = 40; // 縦線の透明度
    var opa2 = 240; // ノイズの透明度

	function OldMoviePlugin(window)
	{
		super.KAGPlugin();
		this.window = window;
	}

	function finalize()
	{
		// finalize メソッド
		// このクラスの管理するすべてのオブジェクトを明示的に破棄
		for(var i = 0; i < noises.count; i++)
			invalidate noises[i];
		invalidate noises;
		for(var i = 0; i < pnoises.count; i++)
			invalidate pnoises[i];
		invalidate pnoises;

		invalidate timer if timer !== void;

		super.finalize(...);
	}

	function init(num, num2, options)
	{
    	w = window.primaryLayer.width; 
        h = window.primaryLayer.height;
        l = +options.left if options.left !== void;
        t = +options.top if options.top !== void;
        w = +options.width if options.width !== void;
        h = +options.height if options.height !== void;
    
		// num 個の縦線、num2 個のノイズを出現させる
		if(timer !== void) return; // すでに効果はでている

		// 縦線を作成
		for(var i = 0; i < num; i++)
		{
			noises[i] = new OldMovie(window, 0, h, opa, opa2, this);
    		noises[i].spawn(l,t,w,h);
		}

		// ノイズを作成
		for(var i = 0; i < num2; i++)
		{
			pnoises[i] = new OldMovie(window, 1, h, opa, opa2, this);
    		pnoises[i].spawn(l,t,w,h);
		}

		// タイマーを作成
		timer = new Timer(onTimer, '');
		timer.interval = 150;
		timer.enabled = true;

		foreVisible = true;
		backVisible = true;
		setOptions(options); // オプションを設定
	}

	function uninit()
	{
		// 効果を消す
		if(timer === void) return; // 効果はでていない

		for(var i = 0; i < noises.count; i++)
			invalidate noises[i];
		noises.count = 0;
		for(var i = 0; i < pnoises.count; i++)
			invalidate pnoises[i];
		pnoises.count = 0;

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
		var noisecount = noises.count;
		for(var i = 0; i < noisecount; i++)
			noises[i].move(l, t, w, h); // move メソッドを呼び出す
		var pnoisecount = pnoises.count;
		for(var i = 0; i < pnoisecount; i++)
			pnoises[i].move(l, t, w, h); // move メソッドを呼び出す
	}

	function resetVisibleState()
	{
		// すべての効果の 表示・非表示の状態を再設定する
		var noisecount = noises.count;
		for(var i = 0; i < noisecount; i++)
			noises[i].resetVisibleState(); // resetVisibleState メソッドを呼び出す
		var pnoisecount = pnoises.count;
		for(var i = 0; i < pnoisecount; i++)
			pnoises[i].resetVisibleState(); // resetVisibleState メソッドを呼び出す
	}

	function onStore(f, elm)
	{
		// 栞を保存するとき
		var dic = f.noises = %[];
		var dic2 = f.pnoises = %[];
		dic.init = timer !== void;
		dic.foreVisible = foreVisible;
		dic.backVisible = backVisible;
		dic.noiseCount = noises.count;
        dic.l = l;
        dic.t = t;
        dic.w = w;
        dic.h = h;
		dic2.pnoiseCount = pnoises.count;
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.noises;
        var dic2 = f.pnoises;
		if(dic === void || !+dic.init)
		{
			// 効果はでていない
			uninit();
		}
		else if(dic !== void && +dic.init)
		{
			// 効果はでていた
			init(dic.noiseCount, dic2.pnoiseCount, %[ forevisible : dic.foreVisible, backvisible : dic.backVisible , left : dic.l , top : dic.t , width : dic.w , height : dic.h ] );
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
		// このプラグインではコピーすべき情報は表示・非表示の情報だけ
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
		var noisecount = noises.count;
		for(var i = 0; i < noisecount; i++)
			noises[i].exchangeForeBack(); // move メソッドを呼び出す
		var pnoisecount = pnoises.count;
		for(var i = 0; i < pnoisecount; i++)
			pnoises[i].exchangeForeBack(); // move メソッドを呼び出す
	}
}

kag.addPlugin(global.oldMovie_object = new OldMoviePlugin(kag));
	// プラグインオブジェクトを作成し、登録する

@endscript
@endif
; マクロ登録
@macro name="oldMovieinit"
@eval exp="oldMovie_object.init(2, 3, mp)"
; ここの2, 3 の数値を変えることで、表示する縦線とノイズの数を変更できます。
@endmacro
@macro name="oldMovieuninit"
@eval exp="oldMovie_object.uninit()"
@endmacro
@macro name="oldMovieopt"
@eval exp="oldMovie_object.setOptions(mp)"
@endmacro
@return
