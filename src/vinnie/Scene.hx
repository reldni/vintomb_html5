package vinnie;
import haxe.ds.IntMap;
import haxe.Timer;
import js.Browser;
import js.html.*;
import js.html.svg.LinearGradientElement;
import vinnie.Inventory.InventoryItem;
import vinnie.Inventory.InventoryItemType;
import vinnie.Assets;

@:autoBuild( vinnie.Macros.buildScene() )
class Scene
{
    public function new( game : Vinnie )
    {
        this.game = game;
        this.audio = game.audio;
        document = Browser.document;
        body = document.body;
        inventory = game.inventory;
        width = 300;
        height = 200;
        title = "";
        allowDragging = true;
        allowEndDragging = true;
        equippedItem = null;
        scale = 1;
    }

    public function preload() {
        inventory.preloadItems();
        game.preloader.preloadArt( Assets.vinnie );
        game.preloader.preloadArt( Assets.vinnieShades );
        game.preloader.preloadArt( Assets.info );
        game.preloader.preloadArt( Assets.caution );
        game.preloader.preloadArt( Assets.msgboxClose );
        game.preloader.preloadSound( Assets.death );
        game.preloader.preloadSound( Assets.getItem );
        game.preloader.preloadSound( Assets.getItem );
        game.preloader.preloadSound( Assets.completeScene );
        game.preloader.preloadSound( Assets.eureka );
    }

    public function registerSounds()
    {
        audio.registerSound( Assets.death );
        audio.registerSound( Assets.getItem );
        audio.registerSound( Assets.getItem );
        audio.registerSound( Assets.completeScene );
        audio.registerSound( Assets.eureka );
    }

    public function start()
    {
        registerSounds();

        mainView = document.createDivElement();
        //mainView.style.border = "1px solid black";
        mainView.style.padding = "0";
        mainView.style.margin = "0";
        mainView.style.position = "absolute";
        mainView.style.width = '${width}px';
        mainView.style.height = '${height}px';
        mainView.style.top = "50%";
        mainView.style.left = "50%";
        mainView.style.marginLeft = '-${width/2}px';
        mainView.style.marginTop = '-${height/2}px';
        mainView.style.overflow = "hidden";
        body.appendChild( mainView );

        mouseX = 0;
        mouseY = 0;
        mainView.onmousemove = onMouseMove;
        mainView.addEventListener( "touchstart", onTouchStart );
        body.addEventListener( "touchmove", onTouchMove );
        body.addEventListener( "touchend", onTouchEnd );

        updatePosition();

        var newTitle = "Vinnie's Tomb";
        if( title != "" && title != null )
        {
            newTitle += ' - $title';
        }
        document.title = newTitle;

        inventory.hide();
        setCursor( null );
    }

    public function end()
    {
        destroyView();
        audio.stopMusic();
        audio.unregisterAll();
    }

    function destroyView()
    {
        body.removeEventListener( "touchmove", onTouchMove );
        body.removeEventListener( "touchend", onTouchEnd );

        if( mainView != null )
        {
            if( mainView.parentNode != null )
            {
                mainView.parentNode.removeChild( mainView );
            }
            mainView.removeEventListener( "touchstart", onTouchStart );
            mainView = null;
        }
        inventory.hide();
    }

    public function updatePosition()
    {
        var screenWidth = Browser.window.innerWidth;
        var screenHeight = Browser.window.innerHeight;
        scale = Math.min( screenWidth / width, screenHeight / height );

        if( !game.isMobile )
        {
            scale = Math.round( scale / .25 ) * .25;
        }
        scale = Math.min( scale, 2  );
        if( mainView != null && scale != 1 )
        {
            mainView.style.transform = 'scale($scale,$scale)';
        }
        inventory.resetPosition();
    }

    public function giveItem( msg : String )
    {
        audio.playSound( Assets.getItem );
        message( msg );
    }

    public function message( msg : String, ?title : String, ?icon : MessageIcon ) : MessageHandle
    {
        var modalDiv = document.createDivElement();
        modalDiv.style.position = "fixed";
        modalDiv.style.width = "100%";
        modalDiv.style.height = "100%";
        modalDiv.style.zIndex = "10003";

        var bgDiv = document.createDivElement();
        bgDiv.style.position = "fixed";
        bgDiv.style.width = "100%";
        bgDiv.style.height = "100%";
        bgDiv.style.backgroundColor = "black";
        bgDiv.style.opacity = "0.6";
        modalDiv.appendChild( bgDiv );

        var msgDiv = document.createDivElement();
        msgDiv.style.opacity = "1";
        msgDiv.style.backgroundColor = "#c0c0c0";
        msgDiv.style.zIndex = "10004";
        msgDiv.style.textAlign = "left";
        msgDiv.style.fontFamily = '"MS Sans Serif", sans-serif';
        msgDiv.style.fontSize = "8.25pt";
        msgDiv.style.borderStyle = "outset";
        msgDiv.style.borderColor = "#ffffff #808080 #808080 #ffffff";
        msgDiv.style.cursor = "default";
        msgDiv.style.position = "fixed";
        modalDiv.appendChild( msgDiv );

        var titleDiv = document.createDivElement();
        titleDiv.style.height = "10px";
        titleDiv.style.padding = "4px";
        titleDiv.style.marginBottom = "14px";
        titleDiv.style.backgroundColor = "#000080";
        titleDiv.style.fontWeight = "700";
        titleDiv.style.color = "white";
        titleDiv.style.textAlign = "left";
        titleDiv.appendChild( document.createTextNode( title != null ? title : "Vinnie's Tomb" ) );

        var closeImg = document.createImageElement();
        closeImg.src = Assets.msgboxClose.url;
        closeImg.style.position = "absolute";
        closeImg.style.top = "2px";
        titleDiv.appendChild( closeImg );

        msgDiv.appendChild( titleDiv );

        if( icon == null )
        {
            icon = Info;
        }

        if( icon != None )
        {
            var iconDiv = document.createImageElement();
            iconDiv.src = switch( icon )
            {
                case Info:      Assets.info.url;
                case Caution:   Assets.caution.url;
                case _:         "";
            }
            iconDiv.style.display = "block";
            iconDiv.style.position = "absolute";
            iconDiv.style.left = "13px";
            iconDiv.style.top = "32px";
            msgDiv.appendChild( iconDiv );
        }

        var textDiv = document.createDivElement();
        textDiv.appendChild( document.createTextNode(msg) );
        msgDiv.appendChild( textDiv );

        var okButton = document.createButtonElement();
        okButton.style.display = "block";
        okButton.style.margin = "0 auto 13px auto";
        okButton.style.backgroundColor = "#c0c0c0";
        okButton.style.width = "75px";
        okButton.style.height = "23px";
        okButton.appendChild( document.createTextNode("OK") );
        msgDiv.appendChild( okButton );
        body.appendChild( modalDiv );

        var height = msgDiv.clientHeight;
        msgDiv.style.marginTop = '-${height/2}px';

        game.isPaused = true;
        okButton.focus();

        var width = 500.0;
        var textWidth = textDiv.clientWidth;
        if( textWidth > 0 )
        {
            width = Math.min( 500, textWidth );
        }
        if( icon != None )
        {
            textDiv.style.margin = "24px 13px 30px 62px";
            width += 76;
        }
        else
        {
            textDiv.style.margin = "24px 13px 30px 13px";
            width += 26;
        }

        msgDiv.style.width = '${width}px';
        msgDiv.style.margin = "0";
        msgDiv.style.position = "fixed";
        var msgX = (Browser.window.innerWidth - msgDiv.clientWidth) / 2;
        var msgY = (Browser.window.innerHeight - msgDiv.clientHeight) / 2;
        msgDiv.style.left = '${msgX}px';
        msgDiv.style.top = '${msgY}px';

        titleDiv.style.width = '${width-8}px';
        closeImg.style.left = '${width - 19}px';

        titleDiv.onmousedown = function(e) {
            var ix = e.pageX;
            var iy = e.pageY;

            function stopDrag() {
                document.onmouseleave = document.onmousemove = document.onmouseup = null;
            }

            document.onmousemove = function(e) {
                msgX += e.pageX - ix;
                msgY += e.pageY - iy;
                msgDiv.style.left = '${msgX}px';
                msgDiv.style.top = '${msgY}px';
                ix = e.pageX;
                iy = e.pageY;
            }

            document.onmouseup = stopDrag;
            document.onmouseleave = stopDrag;
        };

        return new MessageHandle( game, modalDiv, okButton );
        // OLD:
        //Browser.alert( msg );
    }

    function makeArt( art : Art, x : Int, y : Int, ?onClick : Void->Void )
    {
        var img = document.createImageElement();
        img.src = art.url;
        img.style.position = "absolute";
        img.style.left = '${x}px';
        img.style.top = '${y}px';
        if( onClick != null )
        {
            var f = makeHandler( onClick );
            img.onclick = function(e) { f(); }
        }
        mainView.appendChild( img );
        return img;
    }

    inline function playSound( sound : Sound, pause : Bool = false )
    {
        return audio.playSound( sound, pause );
    }


    inline function playMusic( music : Music )
    {
        return audio.playMusic( music );
    }

    function makeRect( x : Int, y : Int, width : Int, height : Int, ?color : String )
    {
        var div = document.createDivElement();
        div.style.position = "absolute";
        if( color != null )
        {
            div.style.backgroundColor = color;
        }
        div.style.left = '${x}px';
        div.style.top = '${y}px';
        div.style.width = '${width}px';
        div.style.height = '${height}px';
        mainView.appendChild( div );
        return div;
    }

    function makeVinnie( x : Int, y : Int )
    {
        vinnie = makeArt( Assets.vinnie, x, y );
        vinnie.style.zIndex = "999";
        vinnie.onclick = function( e ) {
            if( !isDraggingVinnie && !game.isPaused )
            {
                onVinnieClicked();
                if( e != null )
                {
                    e.stopPropagation();
                }
            }
        };
        if( game.shadesOn ) wearShades();
        return vinnie;
    }

    public function wearShades()
    {
        if( vinnie != null )
        {
            vinnie.src = Assets.vinnieShades.url;
        }
    }

    function makeItem( itemType : InventoryItemType, x : Int, y : Int, mustDrag : Bool = true, ?customHandler : Void -> Void )
    {
        var itemInfo = Inventory.itemInfo.get( itemType );
        if( itemInfo == null )
        {
            return null;
        }

        var item : Element = null;
        var getItem = makeHandler( function()
        {
            if( !mustDrag || isDraggingVinnie )
            {
                if( customHandler == null )
                {
                    item.parentNode.removeChild( item );
                    obtainItem( itemType );
                }
                else
                {
                    customHandler();
                }
            }
        } );
        item = makeArt( itemInfo.icon, x, y, getItem );
        return item;
    }

    function makeClickHotspot( x : Int, y : Int, width : Int, height : Int, handler : Void->Void )
    {
        var hotspot = document.createDivElement();
        hotspot.style.position = "absolute";
        hotspot.style.left = '${x}px';
        hotspot.style.top = '${y}px';
        hotspot.style.width = '${width}px';
        hotspot.style.height = '${height}px';
        hotspot.onclick = makeHandler( handler );
        mainView.appendChild( hotspot );
        return hotspot;
    }

    function makeHoverHotspot( x : Int, y : Int, width : Int, height : Int, handler : Void->Void )
    {
        var hotspot = document.createDivElement();
        hotspot.style.position = "absolute";
        hotspot.style.left = '${x}px';
        hotspot.style.top = '${y}px';
        hotspot.style.width = '${width}px';
        hotspot.style.height = '${height}px';
        hotspot.onmouseover = makeHandler( handler );
        hotspot.ontouchmove = makeHandler( handler );
        mainView.appendChild( hotspot );
        return hotspot;
    }

    function makeDialogBox( x : Int, y : Int, width : Int, height : Int, ?textColor : String, ?bgColor : String )
    {
        var div = makeRect( x, y, width, height );
        div.style.fontFamily = '"MS Sans Serif", sans-serif';
        div.style.fontWeight = "700";
        div.style.fontSize = "8.25pt";
        if( textColor != null ) div.style.color = textColor;
        if( bgColor != null ) div.style.background = bgColor;
        div.style.cursor = "default";
        var text = document.createTextNode( "" );
        div.appendChild( text );
        return div;
    }

    function obtainItem( itemType : InventoryItemType )
    {
        var itemInfo = Inventory.itemInfo.get( itemType );
        if( itemInfo != null )
        {
            audio.playSound( Assets.getItem, true ).then(
                function()
                {
                    inventory.addItem( itemType );
                    inventory.show();
                    message( 'You now have ${itemInfo.name}', "Item collected!" );
                    cancelDrag();
                }
            );
        }
    }

    function onVinnieClicked()
    {
        if( isDraggingVinnie )
        {
            onVinnieEndDrag( null );
            return;
        }

        if( allowDragging )
        {
            isDraggingVinnie = true;
            document.onclick = onVinnieEndDrag;
            vinnie.style.display = "none";
            setCursor( game.shadesOn ? Assets.vinnieShades : Assets.vinnie );
            if( equippedItem != null ) equippedItem = null;
        }
    }

    function onVinnieEndDrag( _ )
    {
        if( allowEndDragging )
        {
            document.onclick = null;
            vinnie.style.display = "block";
            if( cursor != null )
            {
                vinnie.style.top = cursor.style.top;
                vinnie.style.left = cursor.style.left;
            }
            setCursor( null );
            isDraggingVinnie = false;
        }
    }

    function cancelDrag()
    {
        if( isDraggingVinnie )
        {
            setCursor( null );
            document.onclick = null;
            vinnie.style.display = "block";
            isDraggingVinnie = false;
        }
    }

    function makeHandler( f : Void->Void ) : Void->Void
    {
        return function()
        {
            if( !game.isPaused )
            {
                f();
            }
        }
    }

    function nextScene( nextScene : Class<Scene>, ?passCode : String, ?msg : String )
    {
        audio.playSound( Assets.completeScene, true ).then( function() {
            var handle = message( msg == null ? 'You have completed $title' : msg );

            var showPasscode = false;
            if( passCode != null )
            {
                var gameData = MainMenu.PASSCODE_GAMES.get( passCode );
                if( gameData != null )
                {
                    showPasscode = game.shadesOn == gameData.shades;
                    for( item in gameData.inventory )
                    {
                        if( !inventory.hasItem( item ) )
                        {
                            showPasscode = false;
                            break;
                        }
                    }
                }
            }

            var gotoNextScene = function() {
                var scene = Type.createInstance( nextScene, [game] );
                game.startScene( scene );
            }

            if(showPasscode)
            {
                handle.then(function () {
                    message( '$passCode', "Remember This Pass Code" ).then( gotoNextScene );
                } );
            }
            else
            {
                handle.then( gotoNextScene );
            }
        } );
    }

    function transitionToNextScene( nextScene : Class<Scene>, transition : (Void->Void)->Void )
    {
        mainView.style.display = "none";
        audio.stopMusic();
        transition( function() {
            var scene = Type.createInstance( nextScene, [game] );
            game.startScene( scene );
        } );
    }

    function bonusScene( id : Int )
    {
        if( game.bonusScenes && !game.bonusSceneCompleted[ id ] )
        {
            message( "YOU HAVE FOUND A HIDDEN BONUS SCENE" ).then( function() {
                game.startScene( new ActionScene( game, Type.getClass( this ), id ) );
            } );
        }
    }

    function vinnieDied()
    {
        game.isPaused = true;
        allowDragging = false;
        audio.playSound( Assets.death );
        if( vinnie != null )
            vinnie.onclick = function(_) exitGame();
    }

    function exitGame()
    {
        if( Browser.window.top != null )
        {
            Browser.window.top.location.href = Vinnie.EXIT_URL;
        }
        else
        {
            document.location.href = Vinnie.EXIT_URL;
        }
    }

    function isEquipped( itemType : InventoryItemType )
    {
        return equippedItem != null && equippedItem.type == itemType;
    }

    public function equipItem( item : InventoryItem )
    {
        if( !isDraggingVinnie )
        {
            if( item != null )
            {
                equippedItem = item;
                setCursor( equippedItem.icon );
                cursor.style.top = "-1000px";
            }
            else
            {
                equippedItem = null;
                setCursor( null );
            }
        }
    }

    function setCursor( art : Null<Art> )
    {
        // Clear previous cursor.
        if( cursor != null && cursor.parentNode != null )
        {
            cursor.parentNode.removeChild( cursor );
            cursor = null;
        }

        if( mainView != null )
        {
            if( art != null )
            {
                mainView.style.cursor = "none";

                cursor = makeArt( art, 0, 0 );
                cursor.style.zIndex = "9999";

                var viewRect = mainView.getBoundingClientRect();

                var x = (mouseX - viewRect.left)/scale - 16;
                var y = (mouseY - viewRect.top)/scale - 16;
                cursor.style.left = '${x}px';
                cursor.style.top = '${y}px';

                cursor.style.setProperty( "pointer-events", "none" );
            }
            else
            {
                mainView.style.cursor = "auto";
            }
        }
    }

    function onMouseMove( e )
    {
        if( e.currentTarget == mainView )
        {
            mouseX = e.clientX;
            mouseY = e.clientY;
            var viewRect = mainView.getBoundingClientRect();
            if( cursor != null )
            {
                var x = (mouseX - viewRect.left)/scale - 16;
                var y = (mouseY - viewRect.top)/scale - 16;

                cursor.style.left = '${x}px';
                cursor.style.top = '${y}px';
            }
        }
    }

    function onTouchStart( e : TouchEvent )
    {
        if( !game.isPaused && e.currentTarget == mainView )
        {
            mouseX = e.touches[0].clientX;
            mouseY = e.touches[0].clientY;
            touchStartElement = e.touches[0].target;
            var viewRect = mainView.getBoundingClientRect();
            if( vinnie != null && !isDraggingVinnie )
            {
                var x = (e.touches[0].clientX - viewRect.left)/scale;
                var y = (e.touches[0].clientY - viewRect.top)/scale;
                var dx = x - (vinnie.offsetLeft + 16);
                var dy = y - (vinnie.offsetTop + 16);
                var dist = Math.sqrt( dx * dx + dy * dy );
                if( dist <= 40 )
                {
                    onVinnieClicked();
                    e.stopPropagation();
                    return false;
                }
            }
        }

        return true;
    }

    function onTouchMove( e : TouchEvent )
    {
        if( e.currentTarget == body )
        {
            var dx = e.touches[0].clientX - mouseX;

            mouseX = e.touches[0].clientX;
            mouseY = e.touches[0].clientY;

            var viewRect = mainView.getBoundingClientRect();
            var x = (mouseX - viewRect.left)/scale;
            var y = (mouseY - viewRect.top)/scale;

            if( (x < 0 || x > width || y < 0 || y > height) )
            {
                return true;
            }

            if( cursor != null )
            {
                cursor.style.left = '${x-16}px';
                cursor.style.top = '${y-16}px';
            }

            if( !game.isPaused )
            {
                if( !isDraggingVinnie && equippedItem == null && dialogScroller != null )
                {
                    dialogGotoLine( dx < 0 ? curDialogLine + 1 : curDialogLine - 1 );
                }

                var obj = document.elementFromPoint( e.touches[0].pageX, e.touches[0].pageY );
                if( obj != null && obj.onmouseover != null )
                {
                    obj.onmouseover(null);
                }
            }
        }

        return true;
    }

    function onTouchEnd( e : TouchEvent )
    {
        if(  e.touches.length == 0 )
        {
            if( !game.isPaused )
            {
                var obj = document.elementFromPoint( e.changedTouches[0].pageX, e.changedTouches[0].pageY );
                if( obj != null && obj.onclick != null && !(untyped obj.disabled) && obj != touchStartElement )
                {
                    obj.onclick(null);
                }
            }

            if( isDraggingVinnie )
            {
                vinnie.style.display = "block";
                onVinnieEndDrag(null);
            }

            touchStartElement = null;

            return false;
        }

        return true;
    }

    function dialog( lines : Array<Void->Void> )
    {
        var scrollContainer = document.createDivElement();
        scrollContainer.style.position = "absolute";
        scrollContainer.style.width = '${width}px';
        scrollContainer.style.height = '16px';
        scrollContainer.style.bottom = "0";
        scrollContainer.style.left = "0";
        scrollContainer.style.zIndex = "9000";
        mainView.appendChild( scrollContainer );

        var scrollBar = document.createDivElement();
        scrollBar.style.width = '${width}px';
        scrollBar.style.overflowX = "scroll";
        scrollBar.style.overflowY = "hidden";
        scrollBar.style.position = "absolute";
        scrollBar.style.zIndex = "9000";
        scrollContainer.appendChild( scrollBar );
        dialogScroller = scrollBar;

        var innerDiv = document.createDivElement();
        innerDiv.style.width = '${width*10}px';
        innerDiv.style.height = "1px";
        scrollBar.appendChild( innerDiv );

        dialogLines = lines;

        curDialogLine = 0;
        curDialogScroll = dialogScroller.scrollLeft;
        dialogScroller.scrollLeft = 0;
        if( dialogLines != null && dialogLines.length > 0 )
        {
            dialogLines[0]();
        }

        // Register scroll listener as passive to avoid issues with async scrolling in modern browsers.
        var options = { passive: false };
        dialogScroller.addEventListener( "scroll", onDialogScroll, options );

        return scrollContainer;
    }

    function onDialogScroll(e)
    {
        if( e.currentTarget == dialogScroller && !game.isPaused && dialogScroller.scrollLeft != curDialogScroll )
        {
            // We want to mimic Win95 style scrollbars that "snap" immediately to the new position.
            // To prevent inertial scrolling in modern browsers, reset the scroll position.
            var line = curDialogLine + (dialogScroller.scrollLeft > curDialogScroll ? 1 : -1);
            dialogScroller.scrollLeft = curDialogScroll;

            // Update dialog.
            dialogGotoLine( line );
        }

        e.preventDefault();

        return false;
    }

    function dialogGotoLine( line )
    {
        if( isDialogScrolling )
        {
            dialogScroller.scrollLeft = curDialogScroll;
            if( scrollTimer != null ) scrollTimer.stop();
            scrollTimer = new Timer( 150 );
            scrollTimer.run = onScrollStopped;
            return;
        }

        if( dialogLines == null || dialogLines.length <= 1 )
        {
            return;
        }

        if( line < 0 ) line = 0;
        if( line >= dialogLines.length ) line = dialogLines.length - 1;

        if( curDialogLine != line )
        {
            curDialogLine = line;
            var dialogLine = dialogLines[ curDialogLine ];
            if( dialogLine != null ) dialogLine();
            var maxScroll = dialogScroller.scrollWidth - dialogScroller.clientWidth;
            curDialogScroll = Std.int( curDialogLine * maxScroll / (dialogLines.length - 1) );
            dialogScroller.scrollLeft = curDialogScroll;
        }

        isDialogScrolling = true;
        scrollTimer = new Timer( 150 );
        scrollTimer.run = onScrollStopped;
    }

    function onScrollStopped()
    {
        isDialogScrolling = false;
        scrollTimer.stop();
        scrollTimer = null;
    }

    function animate( elem : Element, time : Float, properties : Map<String,Int>, ?onComplete : Void->Void )
    {
        var gotTime = false;
        var curTime = 0.0;
        var startTime = 0.0;

        var propDeltas : Array<{name:String, val:Float, speed:Float, to:Int}> = new Array();
        for( propName in properties.keys() )
        {
            var value = Std.parseInt( elem.style.getPropertyValue( propName ) );
            if( value != null )
            {
                var to = properties.get( propName );
                var speed = (to - value) / time;
                propDeltas.push( {
                    name:   propName,
                    val:    value,
                    speed:  speed,
                    to:     to
                } );
            }
        }

        time *= 1000;

        function animator( t : Float )
        {
            if( !gotTime )
            {
                curTime = t;
                startTime = t;
                gotTime = true;
            }
            var dt = (t - curTime) / 1000;
            curTime = t;

            for( prop in propDeltas )
            {
                prop.val += prop.speed * dt;
                elem.style.setProperty( prop.name, '${prop.val}px' );
            }

            if( curTime - startTime < time )
            {
                Browser.window.requestAnimationFrame( animator );
            }
            else
            {
                for( prop in propDeltas )
                {
                    prop.val += prop.speed * dt;
                    elem.style.setProperty( prop.name, '${prop.to}px' );
                }

                game.isPaused = false;

                if( onComplete != null )
                {
                    onComplete();
                }
            }
        }

        game.isPaused = true;
        Browser.window.requestAnimationFrame( animator );
    }

    public function getViewRect()
    {
        return mainView != null ? mainView.getBoundingClientRect() : body.getBoundingClientRect();
    }

    public var width(default, null) : Int;
    public var height(default, null) : Int;
    public var title(default, null) : String;

    var game(default, null) : Vinnie;
    var audio(default, null) : AudioManager;
    var document(default, null) : HTMLDocument;
    var body(default, null) : Element;

    var mainView(default, null) : Element;

    var inventory(default, null) : Inventory;

    var dialogScroller : Element;
    var dialogLines : Array<Void->Void>;
    var curDialogLine : Int;
    var curDialogScroll : Int;
    var isDialogScrolling : Bool;
    var scrollTimer : Timer;

    var isDraggingVinnie : Bool;
    var vinnie : ImageElement;
    var allowDragging : Bool;
    var allowEndDragging : Bool;

    var cursor : Null<Element>;
    var mouseX : Float;
    var mouseY : Float;

    var touchStartElement : EventTarget;

    public var scale(default, null) : Float;

    var equippedItem : Null<InventoryItem>;
}

class MessageHandle
{
    public function new( game : Vinnie, modalDiv : Element, okButton : Element )
    {
        onComplete = function() {
            if( modalDiv != null && modalDiv.parentElement != null ) {
                modalDiv.parentElement.removeChild( modalDiv );
            }
            game.isPaused = false;
        }
        okButton.onclick = function(_) onComplete();
    }

    public function then( f : Void->Void ) : MessageHandle
    {
        var oldOnComplete = onComplete;
        onComplete = function() { oldOnComplete(); f(); }
        return this;
    }

    var onComplete : Void->Void;
}

enum MessageIcon
{
    None;
    Info;
    Caution;
}
