package vinnie;
import js.Browser;

class ActionScene extends Scene
{
    static inline var TRAP_WIDTH = 49;
    static inline var TRAP_HEIGHT = 33;

    public static var ACTION_SCENE_DATA = [
        [
            { x: 196, y: 132 },
            { x: 13, y: 128 },
            { x: 89, y: 75 },
            { x: 144, y: 240 },
            { x: 382, y: 173 },
            { x: 301, y: 159 },
        ],
        [
            { x: 249, y: 262 },
            { x: 2, y: 72 },
            { x: 87, y: 73 },
            { x: 188, y: 266 },
            { x: 398, y: 64 },
            { x: 398, y: 70 },
        ],
        [
            { x: 85, y: 231 },
            { x: 378, y: 75 },
            { x: 315, y: 110 },
            { x: 10, y: 264 },
            { x: 239, y: 156  },
            { x: 167, y: 192 },
        ]
    ];

    public function new( game : Vinnie, previousScene : Class<Scene>, sceneId : Int )
    {
        super( game );
        title = "Walk Slowly and Past The Hidden Death Traps";
        allowDragging = false;
        width = 446;
        height = 341;
        this.previousScene = previousScene;
        game.bonusSceneCompleted[ sceneId ] = true;
        traps = ACTION_SCENE_DATA[ sceneId ];
    }

    public override function start()
    {
        super.start();

        message( "IN THIS BONUS SCENE, USE THE ARROW KEYS TO MOVE VINNIE TO THE TOP", "Vinnie's Tomb Bonus Scene" ).then( function() {

            makeArt( Assets.bgAction, 0, 0 );

            vinnieX = 200;
            vinnieY = 305;
            makeVinnie( vinnieX, vinnieY );

            Browser.window.addEventListener( "keydown", onKeyPress );
        } );
    }

    public override function end()
    {
        Browser.window.removeEventListener( "keydown", onKeyPress );
        super.end();
    }

    function onKeyPress( e )
    {
        if( !game.isPaused )
        {
            var dx = 0;
            var dy = 0;
            if( e.keyCode == UP ) dy = -3;
            if( e.keyCode == DOWN ) dy = 3;
            if( e.keyCode == LEFT ) dx = -5;
            if( e.keyCode == RIGHT ) dx = 5;

            vinnieX += dx;
            vinnieY += dy;

            vinnieX = clamp( vinnieX, 0, width - 32 );
            vinnieY = clamp( vinnieY, 0, height - 32 );

            vinnie.style.left = '${vinnieX}px';
            vinnie.style.top = '${vinnieY}px';

            if( traps != null )
            {
                for( trap in traps )
                {
                    if(
                        vinnieX >= trap.x && vinnieX <= trap.x + TRAP_WIDTH &&
                        vinnieY >= trap.y && vinnieY <= trap.y + TRAP_HEIGHT
                    )
                    {
                        onDeathTrap();
                        return false;
                    }
                }
            }

            if( vinnieY <= 0 )
            {
                onWin();
            }
        }

        e.stopPropagation();
        return false;
    }

    inline function clamp( val : Int, min : Int, max : Int ) : Int
    {
        return if( val < min ) min else if( val > max ) max else val;
    }

    function onDeathTrap()
    {
        Browser.window.removeEventListener( "keydown", onKeyPress );
        playSound( Assets.death );
        vinnie.style.display = "none";
        message( "You have stepped on a hidden Death Trap.  You must try again." ).then( function() {
            game.startScene( this );
        } );
    }

    function onWin()
    {
        nextScene( previousScene, null, "You have successfully traversed the field of death traps!" );
    }


    var vinnieX : Int;
    var vinnieY : Int;
    var previousScene : Class<Scene>;
    var traps : Array< {x:Int,y:Int} >;

    static inline var UP = 38;
    static inline var DOWN = 40;
    static inline var LEFT = 37;
    static inline var RIGHT = 39;
}
