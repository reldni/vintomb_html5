package vinnie;

class Scene3 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 398;
        height = 199;
        title = "Scene Three";
    }

    public override function start()
    {
        super.start();

        audio.playMusic( Assets.musicScene3 );

        makeArt( Assets.bgScene3, 0, 0 );

        makeClickHotspot( 66, 150, 57, 45, bonusScene.bind( 0 ) );
        makeClickHotspot( 304, 146, 35, 37, function() message( "CAUTION - This game will rot your brain" ) );
        makeClickHotspot( 152, 136, 73, 57, onHoleClicked );
        makeHoverHotspot( 0, 40, 73, 49, onFried );

        makeVinnie( 352, 88 );

        inventory.show();
    }

    function onHoleClicked()
    {
        audio.playSound( Assets.teleport );
        message( "You have entered the underworld and completed Scene Three" );
        transitionToNextScene( Scene4, underworldTransition );
    }

    function underworldTransition()
    {
        audio.playSound( Assets.nar1 );
        message( "You gently ride down on a cushion of air to the underworld.  You do not have to wander far until you reach two party-bots.  These stationary robots had been fused together to guard and protect.  They were programmed to throw pies at anyone entering the underworld during the war with the drunken eyed sailors of moldville.  The war has been over for years and Underworld has become a wealthy metropolis.  Inside the underworld city lies many lucrative franchises and taco stands.  You know that your journey most likely lies around the outskirts of the Underworld city.  Therefore, you will not have an opportunity to sample the fine dining establishments." );
    }

    function onFried()
    {
        if( isDraggingVinnie )
        {
            message( "You climb to the top of the tree.  A freak bolt of lightning kills you!" );
            cancelDrag();
            vinnie.src = Assets.vinnieFried.url;
            vinnie.style.left = "8px";
            vinnie.style.top = "32px";
            makeArt( Assets.bolt, 24, 8 );
            vinnieDied();
        }
    }

}