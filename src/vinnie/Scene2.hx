package vinnie;
import js.html.Audio;
import js.html.ButtonElement;
import js.html.Element;

class Scene2 extends Scene
{
    static inline var BUTTON_WIDTH = 41;
    static inline var BUTTON_HEIGHT = 49;
    static inline var BRIDGE_X = 47;
    static inline var BRIDGE_Y = 31;

    static var BRIDGE_PATTERN : Array< Array< Null<Bool> > > = [[null, false, null], [false, false, false], [true, true, false], [true, true, false], [false, false, false], [false, false, false], [null, false, null]];

    public function new( game : Vinnie )
    {
        super( game );

        width = 398;
        height = 199;
        title = "Scene Two";
        allowEndDragging = false;
    }

    public override function start()
    {
        super.start();

        audio.playMusic( Assets.musicScene2 );

        makeArt( Assets.bgScene2, 0, 0 );

        crossedBridge = false;

        makeVinnie( 352, 88 );

        sword = makeItem( Sword, 352, 24, false, onSwordClicked );

        vinnieButton = null;

        makeHoverHotspot( 32, 0, 321, 201,
            function()
            {
                if( isDraggingVinnie )
                {
                    resetVinnie();
                    message( "Click on the parts of the bridge to cross the river." );
                }
            }
        );
        makeClickHotspot( 11, 15, 39, 36, function() message( "I could eat a cookie anytime." ) );
        buttonBridge = new Array();
        for( x in 0...7 )
        {
            buttonBridge[x] = new Array();
            for( y in 0...3 )
            {
                if( BRIDGE_PATTERN[x][y] != null )
                {
                    buttonBridge[x][y] = makeButton( x, y, BRIDGE_PATTERN[x][y] );
                }
            }
        }
        buttonBridge[6][1].disabled = false;

        exit = makeArt( Assets.exitLeft, 8, 152, onExitClicked );

    }

    function resetVinnie()
    {
        cancelDrag();
        vinnie.style.left = "352px";
        vinnie.style.top = "88px";
        vinnie.style.display = "block";

        for( ax in 0...7 )
        {
            for( ay in 0...3 )
            {
                var button = buttonBridge[ax][ay];
                if( button != null )
                {
                    button.style.backgroundImage = null;
                    button.disabled = true;
                }
            }
        }

        buttonBridge[6][1].disabled = false;
        vinnieButton = null;
    }

    function makeButton( tileX : Int, tileY : Int, killer : Bool )
    {
        var button = document.createButtonElement();
        button.style.position = "absolute";
        var x = BRIDGE_X + tileX * BUTTON_WIDTH;
        var y = BRIDGE_Y + tileY * BUTTON_HEIGHT;
        button.style.left = '${x}px';
        button.style.top = '${y}px';
        button.style.width = '${BUTTON_WIDTH}px';
        button.style.height = '${BUTTON_HEIGHT}px';
        button.style.backgroundRepeat = "no-repeat";
        button.style.backgroundPosition = "5px 5px";
        button.disabled = true;
        var f = if( killer ) onKillerButtonClick else onButtonClick;
        button.onclick = makeHandler( f.bind( tileX, tileY ) );
        mainView.appendChild( button );
        return button;
    }

    function onSwordClicked()
    {
        if( crossedBridge )
        {
            message( "You can no longer reach the sword." );
        }
        else
        {
            audio.playSound( Assets.getItem, true ).then( function() {
                inventory.addItem( Sword );
                inventory.show();
                cancelDrag();
                sword.parentNode.removeChild( sword );
                resetVinnie();
                message( 'You collect a sword' );
            } );
        }
    }

    function onButtonClick( x : Int, y : Int )
    {
        cancelDrag();

        if( x == 0 && y == 1 )
        {
            onBridgeCrossed();
            return;
        }

        vinnie.style.display = "none";

        if( vinnieButton != null )
        {
            vinnieButton.style.backgroundImage = "";
        }

        var button = buttonBridge[x][y];
        button.style.backgroundImage = 'url("${Assets.vinnie.url}")';
        vinnieButton = button;

        for( ax in 0...7 )
        {
            for( ay in 0...3 )
            {
                button = buttonBridge[ax][ay];
                if( button != null )
                {
                    var dx = Math.abs(ax - x);
                    var dy = Math.abs(ay - y);
                    button.disabled = dx + dy != 1;
                }
            }
        }
    }

    function collapseBridge()
    {
        for( col in buttonBridge )
            for( button in col )
                if( button != null && button.parentNode != null ) button.parentNode.removeChild( button );
    }

    function onBridgeCrossed()
    {
        crossedBridge = true;
        allowDragging = false;
        collapseBridge();
        vinnie.style.display = "block";
        vinnie.style.left = "8px";
        vinnie.style.top = "88px";
        audio.playSound( Assets.death );
        message( "The bridge collapsed!  Fortunately, you have made it to the other side safely." );
    }

    function onKillerButtonClick( x : Int, y : Int )
    {
        game.unlockMedal( Medal.Drowned );
        message( "OH NO!  The Bridge Collapsed!", "Vinnie Drowns", Caution ).then( function() {
            collapseBridge();

            vinnie = makeArt( Assets.vinnieDrown, 128, 88 );
            mainView.appendChild( vinnie );

            if( sword != null && sword.parentNode != null )
            {
                sword.parentNode.removeChild( sword );
            }
            if( exit != null && exit.parentNode != null )
            {
                exit.parentNode.removeChild( exit );
            }

            vinnieDied();
        } );
    }

    function onExitClicked()
    {
        if( crossedBridge )
        {
            nextScene( Scene3, if( inventory.hasItem( Magnet ) && inventory.hasItem( Sword ) ) "ALVIN" else null );
        }
        else
        {
            message( "You must cross the river before you can travel to the next scene.", "Hint" );
        }
    }

    var buttonBridge : Array< Array< ButtonElement > >;
    var vinnieButton : ButtonElement;
    var crossedBridge : Bool;
    var sword : Element;
    var exit : Element;
}