package vinnie;
import js.html.Element;

class Scene14 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 399;
        height = 219;
        title = "Scene Fourteen";
        allowDragging = false;
    }

    public override function start()
    {
        super.start();

        smacks = 0;

        playMusic( Assets.musicScene8 );

        makeArt( Assets.bgScene14, 0, 0 );
        makeClickHotspot( 12, 99, 132, 94, message.bind("1") );
        makeClickHotspot( 301, 135, 39, 33, message.bind("2") );
        // skull 329 34

        tombDoor = makeRect( 0, 100, 151, 93, "#808000" );
        rockCover = makeArt( Assets.bloodRockCover, 277, 132);

        makeClickHotspot( 269, 123, 102, 61, onBloodRockClicked );

        vinnieDialog = makeDialogBox( 62, 84, 224, 61, "black", "white" );
        vinnieLine = makeArt( Assets.scene14Line2, 230, 145 );
        eyeDialog = makeDialogBox( 17, 81, 262, 60, "black", "white" );
        eyeLine = makeArt( Assets.scene14Line1, 82, 141 );

        makeVinnie( 271, 162 );

        eye = makeArt( Assets.eyeGuy, 112, 167 );


        function vinnieSpeak( sound, dialog )
        {
            eye.style.display = "block";
            eyeDialog.style.display = eyeLine.style.display = "none";
            vinnieDialog.style.display = vinnieLine.style.display = "block";
            vinnieDialog.textContent = dialog;
            playSound( sound );
        }

        function eyeSpeak( sound, dialog )
        {
            eye.style.display = "block";
            eyeDialog.style.display = eyeLine.style.display = "block";
            vinnieDialog.style.display = vinnieLine.style.display = "none";
            eyeDialog.textContent = dialog;
            playSound( sound );
        }

        dialog( [
            vinnieSpeak.bind( Assets.vin41, "Hello, is this the entrance to Vinnie's Tomb?" ),
            eyeSpeak.bind( Assets.eye1, "Allegedly, yes.  No one knows how to get in.  There are no doorways." ),
            vinnieSpeak.bind( Assets.vin42, "The entrance must be a secret." ),
            eyeSpeak.bind( Assets.eye2, "I guess so." ),
            vinnieSpeak.bind( Assets.vin44, "What's this gray thing I'm standing in front of?  It's shaped a bit like a tombstone." ),
            eyeSpeak.bind( Assets.eye3, "That is also a mystery.  It is known as the big blood rock.  Don’t ask me why.  I have to go now.  It's time to watch the PBS pledge break.  It’s nice meeting you." ),
            function()
            {
                eye.style.display = "none";
                eyeDialog.style.display = eyeLine.style.display = "none";
                vinnieDialog.style.display = vinnieLine.style.display = "none";
                inventory.show();
            }
        ] );
    }

    function onBloodRockClicked()
    {
        if( rockCover != null )
        {
            if( equippedItem != null && equippedItem.type == SkullThatOozesBloodIntermittently )
            {
                setCursor( Assets.bloodySkull );
                var rockY = rockCover.offsetTop;
                rockY += 5;
                rockCover.style.top = '${rockY}px';
                smacks++;
                if( smacks >= 6 )
                {
                    equipItem( null );
                    inventory.removeItem( SkullThatOozesBloodIntermittently );
                    playSound( Assets.eureka );
                    rockCover.parentNode.removeChild( rockCover );
                    rockCover = null;
                    message( "You crush the skull that oozes blood against the big blood rock.  The big blood rock opens!" );
                }
            }
        }
        else if( equippedItem != null && equippedItem.type == Diamond )
        {
            equipItem( null );
            inventory.removeItem( Diamond );
            diamond = makeArt( Assets.diamond, 301, 135 );
            animate( tombDoor, 3.0, [ "height" => 0 ], onDoorOpened );
        }
    }

    function onDoorOpened()
    {
        tombDoor.style.display = "none";
        playSound( Assets.getItem, true ).then( function() {
            message( "You have opened the main door to Vinnie's Tomb" );
            message( "The glittery diamond has melted into the big blood rock." );
            if( diamond != null )
            {
                diamond.style.display = "none";
            }
            message( 'You have completed $title' );
            game.startScene( new Scene15(game) );
        } );
    }

    var eye : Element;

    var vinnieDialog : Element;
    var eyeDialog : Element;

    var eyeLine : Element;
    var vinnieLine : Element;

    var rockCover : Element;
    var tombDoor : Element;
    var diamond : Element;

    var smacks : Int;
}