package vinnie;

class Scene11 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 401;
        height = 200;
        title = "Scene Eleven";
    }

    public override function start()
    {
        super.start();

        playMusic( Assets.musicScene1 );

        makeArt( Assets.bgScene9Visible, 0, 0 );

        makeHoverHotspot( 0, 0, 401, 153, cancelDrag );
        makeClickHotspot( 8, 32, 193, 169, onHorseClicked );

        makeItem( Key, 200, 168, false, onKeyClicked );

        makeVinnie( 320, 152 );

        inventory.show();
    }

    function onHorseClicked()
    {
        if( isEquipped( Money ) )
        {
            audio.playSound( Assets.getItem, true ).then(
            function()
            {
                equipItem( null );
                inventory.removeItem( Money );
                inventory.addItem( Key );
                message( "You buy the key from the horse.  You now have the key to Vinnie's Tomb!", "Item collected!" ).then( function() {
                    var passCode =
                        if( game.shadesOn )
                        {
                            if( inventory.hasItem( EightBall ) ) "METTA" else "SETTA";
                        }
                        else
                        {
                            if( inventory.hasItem( EightBall ) ) "RETTA" else "NETTA";
                        }
                    nextScene( Scene12, passCode );
                } );
            } );
        }
        else
        {
            if( isDraggingVinnie || equippedItem != null )
            {
                var handler = message( "The horse wants something else for the key.", "Vinnie's Tomb Chapter One", None );
                if( isEquipped( Sword ) )
                {
                    handler.then( message.bind( "You really must stop threatning creatures with your sword." ) );
                }
            }
        }
    }

    function onKeyClicked()
    {
        message( "You cannot take the key.  The horse would get mad." );
    }
}
