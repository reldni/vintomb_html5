package vinnie;
import js.html.Element;

class Scene16 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 395;
        height = 196;
        title = "Scene16";
        allowDragging = false;
    }

    public override function start()
    {
        super.start();

        count = 0;

        playMusic( Assets.musicScene1 );

        makeArt( Assets.bgScene16, 0, 0 );

        panel = makeRect( 56, 72, 283, 123, "#c0c0c0" );
        panel.style.border = "3px outset white";
        var innerPanel = makeRect( 3, 3, 283 - 12, 123 - 12, "#c0c0c0" );
        innerPanel.style.border = "3px outset white";
        panel.appendChild( innerPanel );

        var initX = 13;
        var initY = 13;
        for( x in 0...8 )
            for( y in 0...3 )
            {
                var isOdd = (x + y) & 1 != 0;
                var xPos = initX + x * 32;
                var yPos = initY + y * 32;
                var obj = makeArt( isOdd ? Assets.cheese : Assets.banana, xPos, yPos );
                panel.appendChild( obj );

                if( y == 1 && (x == 0 || x == 7) )
                {
                    obj.style.display = "none";
                    panel.appendChild( makeHoverHotspot( xPos, yPos, 32, 32, onSlotHover.bind( obj, x == 0 ? Cheese : Banana ) ) );
                }
            }

        makeVinnie( 352, 160 );
        inventory.show();
    }

    function onSlotHover( obj, item )
    {
        if( isEquipped( item ) )
        {
            obj.style.display = "block";
            inventory.removeItem( item );
            equipItem( null );
            count++;

            if( count >= 2 )
            {

                animate( panel, 0.6, ["top" => 0, "height" => 195], function() {
                    playSound( Assets.completeScene, true ).then( function() {
                        panel.style.height = "123px";
                        message( "You have complete Scene Sixteen" );
                        game.startScene( new Scene17(game) );
                    } );
                } );

            }
        }
    }

    var panel : Element;
    var count : Int = 0;
}
