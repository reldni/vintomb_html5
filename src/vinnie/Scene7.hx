package vinnie;
import js.html.Element;

class Scene7 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 399;
        height = 199;
        title = "Scene Seven";
        allowEndDragging = false;
    }

    public override function start()
    {
        super.start();

        inventory.show();

        mainView.style.background = "black";

        doorOpened = false;

        playMusic( Assets.musicScene7 );

        makeArt( Assets.bgScene7, 0, 0 );
        makeArt( Assets.funLandEntrance, -6, 19 );

        makeHoverHotspot( 0, 2, 400, 117, cancelDrag );
        makeClickHotspot( 178, 182, 36, 18, function() message( "Yet another useless hidden message." ) );
        makeClickHotspot( 88, 17, 23, 27, function() message( "You wonder what that could be." ) );
        makeClickHotspot( 272, 128, 85, 48, onInsetClicked );

        makeVinnie( 348, 163 );

        line = makeArt( Assets.scene7Line, 97, 28 );
        line.style.display = "none";

        makeClickHotspot( 15, 114, 121, 72, onEntranceClicked );

        door = document.createButtonElement();
        door.style.position = "absolute";
        door.style.left = "24px";
        door.style.top = "123px";
        door.style.width = "106px";
        door.style.height = "58px";
        door.onclick = makeHandler( onDoorClicked );
        mainView.appendChild( door );

        // Image6 178 182 36 18
        // Image5 15 114 121 72
        // Label2  88 17 23 27
        // Label1 0 2 400 117
        // Image4  272 128 85 48
        // Line1  98 29
    }

    function onDoorClicked()
    {
        if( !doorOpened )
        {
            if( equippedItem == null )
            {
                message( "The entrance to Fun Land appears to be closed.  That's a shame because Donny Osmond is hosting a benefit concert there for seven legged spiders from a windy city." );
            }
            else
            {
                message( "That does not open the door." );
            }
        }
    }

    function onInsetClicked()
    {
        if( !doorOpened )
        {
            if( equippedItem == null )
            {
                message( "You wonder what that could be." );
            }
            else if( equippedItem.type != Diamond )
            {
                message( "That will not help open the entrance" );
            }
            else
            {
                playSound( Assets.eureka, true ).then( function() {
                    line.style.display = "block";
                    door.style.display = "none";
                    doorOpened = true;
                    diamond = makeArt( Assets.diamond, 302, 137, onInsetClicked );
                    inventory.removeItem( Diamond );
                    equipItem( null );
                } );
            }
        }
        else if( diamond != null )
        {
            if( equippedItem == null )
            {
                message( "The diamond is stuck." );
            }
            else if( equippedItem.type != Sword )
            {
                message( "That does not do much." );
                equipItem( null );
            }
            else
            {
                playSound( Assets.getItem, true ).then( function() {
                    message( "You pry the glittery diamond back out of the hole with the sword.", "Vinnie's Tomb Chapter One", None );
                    line.style.display = "none";
                    inventory.addItem( Diamond );
                    diamond.parentNode.removeChild( diamond );
                    diamond = null;
                    equipItem( null );
                } );
            }
        }
    }

    function onEntranceClicked()
    {
        if( doorOpened )
        {
            nextScene( Scene8, "LALAL", "You enter Fun Land and complete Scene Seven" );
        }
    }

    var door : Element;
    var doorOpened : Bool;
    var diamond : Element;
    var line : Element;
}
