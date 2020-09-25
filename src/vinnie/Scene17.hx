package vinnie;
import js.html.Element;

class Scene17 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 400;
        height = 200;
        title = "Scene 17";
        allowDragging = false;
    }

    public override function start()
    {
        super.start();

        playMusic( Assets.musicScene2 );

        makeArt( Assets.bgScene17, 0, 0 );
        door = makeArt( Assets.scene17door, 152, 128 );

        makeVinnie( 272, 168 );

        makeHoverHotspot( 304, 168, 41, 33, onBeamHover );
        inventory.show();
    }

    function onBeamHover()
    {
        if( !isEquipped( CD ) )
        {
            message( "You look at the strange beam of light." );
        }
        else
        {
            equipItem( null );
            playSound( Assets.eureka, true ).then( function() {
                makeArt( Assets.cdBeam, 198, 78 );
                message( "You use the CD to reflect the beam of light.  It might not work in real life, but this is only a stupid game." );
                playSound( Assets.completeScene, true ).then( function() {
                    door.style.display = "none";
                    message( "The door opens and you have completed Scene Seventeen." );
                    transitionToNextScene( Scene18,
                        function()
                        {
                            playSound( Assets.death );
                            message( "You walk into the next room of the massive tomb.  Suddenly you are attacked by a giant Dragollater!  He snatches you in his teeth.  You will most likely die!" );
                        }
                    );
                } );
            } );
        }
    }

    var door : Element;
}
