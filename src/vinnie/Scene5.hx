package vinnie;
import js.html.Element;

/**
 * ...
 * @author The Behemoth
 */
class Scene5 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 400;
        height = 197;
        title = "Scene Five";
    }

    public override function start()
    {
        super.start();

        audio.playMusic( Assets.musicScene5 );

        wallMoved = false;

        mainView.style.backgroundColor = "black";

        makeHoverHotspot( 120, 64, 65, 49, onPanelHover );

        makeClickHotspot( 272, 49, 64, 34, function() message( "This is about as scary as it gets.  Enjoy it." ) );
        makeArt( Assets.exitLeft, 8, 64, onExitClicked );

        makeHoverHotspot( 0, 96, 401, 105, onWallHover );

        // invisible?
        makeRect( 0, 112, 121, 89, "#808080" );
        makeRect( 0, 112, 121, 89, "#808080" );
        makeRect( 184, 112, 217, 89, "#808080" );

        makeVinnie( 136, 24 );

        makeRect( 120, 176, 65, 25, "#808080" );
        makeRect( 168, 120, 17, 73, "#808080" );
        makeRect( 120, 120, 17, 73, "#808080" );
        panel1 = makeRect( 120, 112, 65, 17, "#C0C0C0" );
        panel2 = makeRect( 120, 64, 65, 17, "#C0C0C0" );
        panel2.style.display = "none";
        skull = makeItem( SkullThatOozesBloodIntermittently, 136, 136, true, onSkullThatOozesBloodIntermittentlyClicked );

        inventory.show();
    }

    function onPanelHover()
    {
        if( !wallMoved && isEquipped( Magnet) )
        {
            playSound( Assets.eureka, true ).then(function()
            {
                wallMoved = true;
                panel1.style.display = "none";
                panel2.style.display = "block";
            } );
        }
    }

    function onWallHover()
    {
        if( !wallMoved && isDraggingVinnie )
        {
            cancelDrag();
            message( "You cannot break or penetrate the metal walls." );
        }
    }

    function onSkullThatOozesBloodIntermittentlyClicked()
    {
        if( wallMoved && skull != null )
        {
            skull.parentNode.removeChild( skull );
            obtainItem( SkullThatOozesBloodIntermittently );
            skull = null;
        }
    }

    function onExitClicked()
    {
        nextScene( Scene6 );
    }

    var wallMoved : Bool;
    var skull : Element;
    var panel1 : Element;
    var panel2 : Element;
}