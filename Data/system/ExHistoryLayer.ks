;// ExHistoryLayer.ks ( 2004/07/04 ) releaced 1.01
;// メッセージ履歴拡張プラグイン by よかひげ / 改変配布自由自在
;//
;// 注意とお約束。
;// 自己責任下において使用してください。
;// 右クリックサブルーチン内の操作や、タイトルメニューのリンクをメッセージ履歴に垂れ流さないこと。
;//
;// 使い方。
;// 適当な場所で [ call storage="このファイル" ] とすると
;// [ history ] タグが拡張され type 属性が追加されます。
;// [ history type = scroll  ] スクロールバー操作形式
;// [ history type = default ] 吉里吉里標準形式
;// 任意のタイミングで切り替え可能ですが、切り替え時に既存の履歴データが失われる点に注意されたし。
;//
;// 縦書きモードか横書きモードかでスクロールバーの表示位置が変わる関係上、
;// controlHeightの値は 0 固定に設定されるようになっています。
;// スクロールバーの下に文字が隠れる、といった場合は
;// Config.tjs => HistoryLayer_config() 内に追加の設定として
;// ;marginT = 上端マージン
;// ;marginB = 下端マージン
;// ;marginL = 左端マージン
;// ;marginR = 右端マージン
;// の其々の値を設定して状態を是正してください。
;//
;// 1.00 -> 1.01
;// クラス名変更：RButtonLayer -> RapidFireButton
;// 標準添付の kag3plugin サンプル rclick_tjs.ks と重複した為変更。
;//
[if exp=" 'undefined' == typeof global.HistoryLayerExtended" ]
[iscript]
// キホン的な仕組みは HistoryLayer.tjs => LButtonLayer.class と同じ。
// 押しっぱなしにすると parent へのイベント送信を 100ms 周期で行う。
//
class RapidFireButton extends ButtonLayer
{
	var timer;
	function RapidFireButton(window, parent)
	{
		super.ButtonLayer(window, parent);
		focusable = false;
		timer = new Timer( this , "repeat" );
		timer.interval = 100;
	}
	function onMouseDown(x, y, button, shift)
	{
		super.onMouseDown(...);
		if( Butt_mouseDown )
		{
			parent.onButtonClick(this);
			timer.enabled = true;
		}
	}
	function repeat()
	{
		if( Butt_mouseDown ) parent.onButtonClick(this);
		else timer.enabled = false;
	}
	function finalize()
	{
		super.finalize(...);
		invalidate timer;
	}
}
// スライダに変更を加えたい場合はこのクラスに変更を加える。
// ( width / height ) が適時変更される点に留意されたし。
//
class Slider extends ButtonLayer
{
	var dragging;
	function Slider( win , par )
	{
		super.ButtonLayer( win , par );
	}
	function onMouseDown( x , y , button , shift )
	{
		super.onMouseDown(...);
		dragging = ( enabled && button == mbLeft );
	}
	function onMouseUp( x , y , button , shift )
	{
		super.onMouseUp(...);
		dragging = false;
	}
	function onMouseMove( x , y , shift )
	{
		super.onMouseMove(...);
		if( dragging ) parent.onSliderDragged( x , y );
	}
}
/*
interface Scrollbar.Target // 下記メソッドを備えたオブジェクトはスクロールバーと関連付けが可能。
{
	function nextPage(); // nextPage/prevPage/nextLine/prevLine
	function prevPage(); // 各メソッド呼び出し、あるいはそれ以外の要因により
	function nextLine(); // 表示位置 ( position ) が変化した場合、
	function prevLine(); // Scrollbar.target は Scrollbar.updateState メソッドを呼び出す必要がある。
	function isHead();
	function isTail();
	property pageCount;  // setter実装不要
	property lineCount;  // setter実装不要
	property position;   // setter実装不要 返値範囲 1.0（末尾） ～ 0.0（先頭） になるように実装してください。
	property pagebypage; // setter実装不要 返値が true 固定の場合 nextLine/prevLine/lineCount の実装不要。
}
*/
// 縦横の方向性を持たない抽象スクロールバー。
// 縦方向/横方向に共通する操作を実装。
//
class AbstractScrollbar extends Layer
{
	var target,timer;
	var prev,next;
	function AbstractScrollbar( win , par , tar )
	{
		super.Layer( win , par );
		target = tar;
		prev = new RapidFireButton( win , this );
		next = new RapidFireButton( win , this );
		prev.color   = 0x808080;
		next.color   = 0x808080;
		prev.visible = true;
		next.visible = true;
		hitType      = htMask;
		hitThreshold = 0;
	}
	function initState()
	{
		face = dfBoth;
		fillRect( 0 , 0 , width , height , 0xFF404040 );
	}
	function updateState()
	{
		prev.captionColor = ( prev.enabled = !target.isHead() ) ? 0xCCCCCC : 0x808080;
		next.captionColor = ( next.enabled = !target.isTail() ) ? 0xCCCCCC : 0x808080;
	}
	function onButtonClick( src )
	{
		if( src == prev ) target.prevPage(); else
		if( src == next ) target.nextPage();
	}
	function finalize()
	{
		invalidate prev if prev !== void;;
		invalidate next if next !== void;;
	}
}
// 縦方向スクロールバー。
//
class VerticalScrollbar extends AbstractScrollbar
{
	var slider;
	function VerticalScrollbar( win , par , tar )
	{
		super.AbstractScrollbar( win , par , tar );
		prev.caption = "▲";
		next.caption = "▼";
		slider = new Slider( win , this );
		slider.color = 0x808080;
		slider.visible = true;
	}
	// 矢印ボタンに画像を読み込ませたい場合は↑↓を変更してくだされ。
	function initState()
	{
		super.initState(...);
		next.height = prev.height = width;
		prev.width  = next.width  = width;
		prev.left   = next.left   = 0;
		prev.top    = 0;
		next.top    = height - width;
		
		var btnlen    = ( ( height - next.height - prev.height ) / target.pageCount ) \ 1;
		slider.height = ( btnlen > 1 ) ? btnlen : 1;
		slider.width  = width;
		slider.left   = 0;
		slider.top    = prev.height + ( ( height - slider.height - next.height - prev.height ) * target.position ) \ 1;
	}
	function updateState()
	{
		super.updateState(...);
		slider.enabled = !( target.isHead() && target.isTail() );
		slider.top     = prev.height + ( ( height - slider.height - next.height - prev.height ) * target.position ) \ 1;
	}
	function onSliderDragged( x , y )
	{
		if( target.pagebypage )
		{
			var len = slider.height;
			if( y <             0 ){ for( var i = 0; i > ( ( y +             0 ) / len ) ; i-- ) target.prevPage(); } else
			if( y > slider.height ){ for( var i = 0; i < ( ( y - slider.height ) / len ) ; i++ ) target.nextPage(); }
		}
		else
		{
			var len = ( height - next.height - prev.height ) / target.lineCount;
			if( y <             0 ){ for( var i = 0; i > ( ( y +             0 ) / len ) ; i-- ) target.prevLine(); } else
			if( y > slider.height ){ for( var i = 0; i < ( ( y - slider.height ) / len ) ; i++ ) target.nextLine(); }
		}
	}
	// スクロールバー上を押しっぱなし際に、 prev/next 押しっぱなしと同等の動作をさせる為の仕組み。
	var tmr; ( tmr = new Timer( this , "repeat" ) ).interval = 100;
	var dst;
	function scrollTo( value )
	{
		dst = value;
		tmr.enabled = true;
	}
	function repeat()
	{
		if( dst < slider.top                 ) ( target.pagebypage ) ? target.prevPage() : target.prevLine(); else
		if( dst > slider.top + slider.height ) ( target.pagebypage ) ? target.nextPage() : target.nextLine(); else
		tmr.enabled = false;
	}
	function onMouseDown( x , y , button , shift  )
	{
		super.onMouseDown(...);
		if( y < slider.top                 ){ ( target.pagebypage ) ? target.prevPage() : target.prevLine(); scrollTo( y ); } else
		if( y > slider.top + slider.height ){ ( target.pagebypage ) ? target.nextPage() : target.nextLine(); scrollTo( y ); }
	}
	function onMouseMove( x , y , shift )
	{
		if( tmr.enabled ) dst = y;
	}
	function onMouseUp( x , y , button , shift  )
	{
		tmr.enabled = false;
	}
	function finalize()
	{
		super.finalize(...);
		invalidate slider if slider !== void;
		invalidate tmr    if tmr    !== void;
	}
}
// 横方向スクロールバー。
//
class HorizontalScrollbar extends AbstractScrollbar
{
	var prev,next,slider;
	var target;
	function HorizontalScrollbar( win , par , tar )
	{
		super.AbstractScrollbar( win , par , tar );
		prev.caption = "》";
		next.caption = "《";
		slider = new Slider( win , this );
		slider.color = 0x808080;
		slider.visible = true;
	}
	// 矢印ボタンに画像を読み込ませたい場合は↑↓を変更してくだされ。
	function initState()
	{
		super.initState(...);
		next.height = prev.height = height;
		prev.width  = next.width  = height;
		prev.top    = next.top    = 0;
		prev.left   = width - height;
		next.left   = 0;
		
		var btnlen    = ( ( width - next.width - prev.width ) / target.pageCount ) \ 1;
		slider.height = height;
		slider.width  = ( btnlen > 1 ) ? btnlen : 1;
		slider.left   = next.width + ( ( width - slider.width - next.width - prev.width ) * ( 1 - target.position ) ) \ 1;
		slider.top    = 0;
	}
	function updateState()
	{
		super.updateState(...);
		slider.enabled = !( target.isHead() && target.isTail() );
		slider.left    = next.width + ( ( width - slider.width - next.width - prev.width ) * ( 1 - target.position ) ) \ 1;
	}
	function onSliderDragged( x , y )
	{
		if( target.pagebypage )
		{
			var len = slider.width;
			if( x <            0 ){ for( var i = 0; i > ( ( x +            0 ) / len ) ; i-- ) target.nextPage(); } else
			if( x > slider.width ){ for( var i = 0; i < ( ( x - slider.width ) / len ) ; i++ ) target.prevPage(); }
		}
		else
		{
			var len = ( width - next.width - prev.width ) / target.lineCount;
			if( x <            0 ){ for( var i = 0; i > ( ( x +            0 ) / len ) ; i-- ) target.nextLine(); } else
			if( x > slider.width ){ for( var i = 0; i < ( ( x - slider.width ) / len ) ; i++ ) target.prevLine(); }
		}
	}
	// スクロールバー上を押しっぱなし際に、 prev/next 押しっぱなしと同等の動作をさせる為の仕組み。
	var tmr; ( tmr = new Timer( this , "repeat" ) ).interval = 100;
	var dst;
	function scrollTo( value )
	{
		dst = value;
		tmr.enabled = true;
	}
	function repeat()
	{
		if( dst < slider.left                ) ( target.pagebypage ) ? target.nextPage() : target.nextLine(); else
		if( dst > slider.left + slider.width ) ( target.pagebypage ) ? target.prevPage() : target.prevLine(); else
		tmr.enabled = false;
	}
	function onMouseDown( x , y , button , shift  )
	{
		super.onMouseDown(...);
		if( x < slider.left                ){ ( target.pagebypage ) ? target.nextPage() : target.nextLine(); scrollTo( x ); } else
		if( x > slider.left + slider.width ){ ( target.pagebypage ) ? target.prevPage() : target.prevLine(); scrollTo( x ); }
	}
	function onMouseMove( x , y , shift )
	{
		if( tmr.enabled ) dst = x;
	}
	function onMouseUp( x , y , button , shift  )
	{
		tmr.enabled = false;
	}
	function finalize()
	{
		super.finalize(...);
		invalidate slider if slider !== void;
		invalidate tmr    if tmr    !== void;
	}
}
class HistoryLayerExtended extends HistoryLayer
{
	var scrollbar;
	function HistoryLayerExtended( win , par , direction )
	{
		super.HistoryLayer( win , par );
		controlHeight = 0;
	}
	function finalize()
	{
		super.finalize(...);
		invalidate scrollbar if scrollbar !== void;
	}
	function makeButtons() // overrides HistoryLayer.makeButtons()
	{
		if( scrollbar === void )
		{
			closeButton = new LButtonLayer( window , this );
			closeButton.top    = 0;
			closeButton.left   = width - 15;
			closeButton.width  = 15;
			closeButton.height = 15;
			closeButton.hint         = "メッセージ履歴を閉じる";
			closeButton.captionColor = 0xffffff;
			closeButton.color        = 0x808080;
			closeButton.caption      = "×";
			closeButton.visible      = true;
			
			// 縦書きモードの時は上端 15 pixel にスクロールバーを張る。
			if( verticalView )
			{
				scrollbar = new HorizontalScrollbar( window , this , this );
				scrollbar.width  = width - closeButton.width;
				scrollbar.height = 15;
				scrollbar.setPos( 0 , 0 );
				scrollbar.visible = true;
			}
			// 横書きモードの時は右端 15 pixel にスクロールバーを張る。
			else
			{
				scrollbar = new VerticalScrollbar( window , this , this );
				scrollbar.width  = 15;
				scrollbar.height = height - closeButton.height;
				scrollbar.setPos( width - scrollbar.width , closeButton.height );
				scrollbar.visible = true;
			}
		}
		scrollbar.initState();
	}
	function updateButtonState(){ scrollbar.updateState(); } // overrides HistoryLayer.updateButtonState()
	
// HEAD :Scrollbar.Target interface実装部分
//
	//function nextPage() HistoryLayer実装済
	//function prevPage() HistoryLayer実装済
	function nextLine() { scrollUp();   }
	function prevLine() { scrollDown(); }
	function isHead()
	{
		return !( dispStart > 0 );
	}
	function isTail()
	{ 
		if( everypage ) return !( dispStart < dataPages -         1 );
		else            return !( dispStart < dataLines - dispLines );
	}
	property pagebypage { getter() { return everypage; } }
	property lineCount  { getter() { return dataLines; } }
	property pageCount
	{
		getter()
		{
			var res = ( everypage ) ? dataPages : dataLines / repageLine;
			return ( res > 1 ) ? res : 1;
		}
	}
	property position
	{
		getter()
		{
			if( everypage )
			{
				if( pageCount > 1 ) return dispStart / ( pageCount - 1 );
				else return 1;
			}
			else
			{
				if( dataLines > dispLines ) return dispStart / ( dataLines - dispLines );
				else return 0;
			}
		}
	}
//
// TAIL :Scrollbar.Target interface実装部分
//
// おまけ。
// メッセージ履歴が表示された時 dispInit が呼び出されます。
// 非表示になった時は dispUninit が呼び出されます。
//
	function dispInit()
	{
		super.dispInit(...);
	}
	function dispUninit()
	{
		super.dispUninit(...);
	}
}
// [history]タグへの属性追加
//
// type属性 ：default なら従来型のメッセージ履歴
// type属性 ：scroll  ならスクロールバー形式のメッセージ履歴

kag.tagHandlers.history = function( elm )
{
	if( elm.type == "scroll" )
	{
		if( historyLayer instanceof "HistoryLayer" )
		{
			remove( historyLayer );
			invalidate historyLayer if historyLayer !== void;
			historyLayer = new HistoryLayerExtended( this , fore.base );
			add( historyLayer );
		}
	}
	else
	if( elm.type == "default" )
	{
		if( historyLayer instanceof "HistoryLayerExtended" )
		{
			remove( historyLayer );
			invalidate historyLayer if historyLayer !== void;
			historyLayer = new HistoryLayer( this , fore.base );
			add( historyLayer );
		}
	}
	setHistoryOptions( elm );
	return 0;
} incontextof kag;
[endscript]
[endif]
[return]
