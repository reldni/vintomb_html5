package vinnie;
import js.html.Element;


class Scene12 extends Scene
{

    public function new( game : Vinnie )
    {
        super( game );

        width = 399;
        height = 193;
        title = "Scene Twelve";
        allowDragging = false;
    }

    public override function start()
    {
        super.start();

        makeArt( Assets.bgScene12, 0, 0, onChasmClicked );
        makeClickHotspot( 297, 4, 36, 49, bonusScene.bind( 1 ) );
        makeClickHotspot( 31, 123, 27, 27, message.bind( "This isn't funny anymore." ) );
        makeClickHotspot( 94, 101, 31, 37, message.bind( "Keep clicking." ) );
        makeVinnie( 336, 16 );
        jerk = makeArt( Assets.jerk, 344, 16 );
        jerk.style.display = "none";
    }

    function onChasmClicked()
    {
        message( "Travelling for thirty more days you come to a cliff.  You realise you are desperately lost.  You need to find away to rise above Underworld and continue your exciting adventure.  Suddenly a nasty creature jumps from behind you!  It pushes you off the cliff!" );
        jerk.style.display = "block";
        animate( vinnie, 1.0, [ "top" => height + 32 ], onFallComplete );
    }

    function onFallComplete()
    {
        playSound( Assets.death, true ).then(
            function()
            {
                message( "Oddly enough you did not die.  Instead, you landed on a strategically placed mountain of breakfast cereal." );
                playSound( Assets.trainWhistle, true ).then(
                    function()
                    {
                        message( "You discover a nearby train station.  You hop aboard the train bound for an unknown destination." );
                        message( "Being a low budget game, we could not afford a real train, so you'll have to imagine it." );
                        nextScene( Scene13 );
                    }
                );
            }
        );
    }

    var jerk : Element;

}