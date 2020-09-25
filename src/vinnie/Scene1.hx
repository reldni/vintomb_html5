package vinnie;
import js.html.ImageElement;

class Scene1 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 398;
        height = 199;
        title = "Scene One";
    }

    public override function start()
    {
        super.start();

        audio.playMusic( Assets.musicScene1 );

        makeArt( Assets.bgScene1, 0, 0 );

        makeHoverHotspot( 376, 144, 25, 57, cancelDrag );
        makeHoverHotspot( 312, 176, 57, 17, cancelDrag );

        var sadEthel = makeArt( Assets.sadEthel, 339, 144, function() message( "That's Sad Ethel, the sea beastie from Edmonton." ) );

        makeVinnie( 344, 64 );
        makeItem( Magnet, 56, 40 );
        makeClickHotspot( 147, 47, 64, 38, message.bind( "No one is quite sure if this is real grass." ) );
        makeArt( Assets.exitLeft, 8, 168, function() nextScene( Scene2 ) );

        audio.playSound( Assets.narIntro );
    }

}