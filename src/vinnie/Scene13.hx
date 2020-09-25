package vinnie;
import js.html.Element;
import js.html.ImageElement;

class Scene13 extends Scene
{

    public function new( game : Vinnie )
    {
        super( game );

        width = 435;
        height = 254;
        title = "Scene Thirteen";
    }

    public override function start()
    {
        super.start();

        madeSlingshot = false;

        playMusic( Assets.musicScene7 );

        makeArt( Assets.bgScene13, 0, 0 );
        makeClickHotspot( 0, 0, 93, 69, onSphereClicked );
        makeClickHotspot( 146, 204, 103, 49, onGapClicked );
        makeClickHotspot( 317, 231, 50, 24, message.bind( "Join the vinnie's Tomb fan club." ) );
        makeHoverHotspot( 0, 0, 433, 193, onFellInChasm );
        makeArt( Assets.book, 368, 208, onBookClicked );
        slingshot = makeArt( Assets.twig, 256, 192, onSlingshotClicked );
        sphere = makeArt( Assets.sphereOfLight, 12, 0 );
        makeVinnie( 296, 184 );

        exit = makeArt( Assets.exitRight, 392, 16, onExitClicked );
        exit.style.display = "none";

        inventory.show();
    }

    function onBookClicked()
    {
        if( isDraggingVinnie )
        {
            cancelDrag();
            message( "To cross the pit use the sphere of light.  It rests on the other side.  You must wake it if you can.  Then you can get a ride." );
        }
    }

    function onSphereClicked()
    {
        if( isEquipped( EightBall ) )
        {
            message( "The chasm is too wide.  You cannot throw the eight ball that far." );
        }
    }

    function onFellInChasm()
    {
        if( isDraggingVinnie )
        {
            cancelDrag();
            vinnie.style.display = "none";
            vinnieDied();
            message( "You fall into the pit of fear and die!" );
            document.onclick = function(_) exitGame();
        }
    }

    function onGapClicked()
    {
        if( game.bonusScenes )
        {
            bonusScene( 2 );
        }
        else
        {
            // TODO: Can't stop on gap?
            cancelDrag();
        }
    }

    function onSlingshotClicked()
    {
        if( !madeSlingshot )
        {
            if( isEquipped( Underwear ) )
            {
                message( "You stretch the underwear over the forked stick in the ground.  Now you have a neato slingshot device.  Wow, this is a cool game!" );
                slingshot.src = Assets.slingshot.url;
                inventory.removeItem( Underwear );
                equipItem( null );
                madeSlingshot = true;
            }
        }
        else
        {
            if( isEquipped( EightBall ) )
            {
                inventory.removeItem( EightBall );
                equipItem( null );
                crossPitOfFear();
            }
            else
            {
                message( "You can't do that with the forked stick." );
            }
        }
    }

    function crossPitOfFear()
    {
        playSound( Assets.sphereZap );

        allowDragging = false;
        vinnie.style.left = "296px";
        vinnie.style.top = "184px";

        // Shoot 8-ball across.
        var ball = makeArt( Assets.eightBall, 256, 176 );
        animate( ball, 0.4, ["left" => 39, "top" => 27],
        function()
        {
            ball.parentNode.removeChild( ball );
            ball = null;

            // Animate sun across.
            animate( sphere, 0.2, ["left" => 39, "top" => 27],
            animate.bind( sphere, 0.2, ["left" => 62, "top" => 144],
            animate.bind( sphere, 0.2, ["left" => 55, "top" => 27],
            animate.bind( sphere, 0.2, ["left" => 270, "top" => 150],
            animate.bind( sphere, 0.8, ["left" => 270, "top" => 150], pickUpVinnie )))));
        } );
    }

    function pickUpVinnie()
    {
        if( !game.shadesOn )
        {
            message( "The Ball of light blinds you.  Your eyes burn up and you stagger into the pit of fear and die horribly." );
            vinnieDied();
            vinnie.style.display = "none";
            exitGame();
        }
        else
        {
            vinnie.style.display = "none";
            playSound( Assets.sphereZap );
            // Carry vinnie across.
            animate( sphere, 0.2, ["left" => 345, "top" => 0], onPitOfFearCrossed );
        }
    }

    function onPitOfFearCrossed()
    {
        vinnie.style.left = "360px";
        vinnie.style.top = "16px";
        vinnie.style.display = "block";
        exit.style.display = "block";
    }

    function onExitClicked()
    {
        message( "You have crossed the pit of fear!" );
        nextScene( Scene14 );
    }

    var exit : Element;
    var sphere : Element;
    var slingshot : ImageElement;
    var madeSlingshot : Bool;


}