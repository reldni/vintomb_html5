package vinnie;

class Scene15 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 443;
        height = 249;
        title = "Scene Fifteen";
        allowDragging = false;
    }

    public override function start()
    {
        super.start();

        playMusic( Assets.musicScene9 );

        makeArt( Assets.bgScene15, 0, 0 );

        makeClickHotspot( 11, 55, 45, 22, message.bind( "Do not fear.  The game is almost over." ) );

        // rect 167 147 60 53
        makeClickHotspot( 192, 168, 33, 33, onKeyHoleClicked );
        makeVinnie( 114, 168 );

        inventory.show();
    }

    function onKeyHoleClicked()
    {
        if( isEquipped( Key ) )
        {
            message( "You try inserting the key into the keyhole.  The key does not seem to fit!  After a few more futile attempts, you realize that the horse may have tricked you.  Perhaps, the snake brothers owned the only key to Vinnie's Tomb.  You get so mad, that you kick the door.  It creaks open.  It must have been unlocked all the time." );
            nextScene( Scene16 );
        }
        else
        {
            message( "Have you had a complete breakfast today?" );
        }
    }
}
