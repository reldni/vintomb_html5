package vinnie;
import js.html.Element;
import js.html.Text;
import vinnie.Inventory.InventoryItemType;

class Scene6 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 400;
        height = 216;
        title = "Scene Six";
    }

    public override function start()
    {
        super.start();

        allowDragging = false;

        playMusic( Assets.musicScene6 );

        makeArt( Assets.bgScene6, 0, 0 );

        makeClickHotspot( 192, 177, 41, 26, function() message( "This game has nothing to do with Maurice Chevalier." ) );

        queerSnakeDialog = makeDialogBox( 116, 11, 265, 49, "white" );
        vinnieDialog = makeDialogBox( 176, 32, 217, 41, "white" );

        var line1 = makeArt( Assets.scene6Line1, 129, 61 );
        var line2 = makeArt( Assets.scene6Line2, 279, 79 );

        makeVinnie( 328, 144 );

        makeItem( Diamond, 264, 176 );
        makeItem( Banana, 368, 168 );
        queerSnake = makeArt( Assets.queerSnake, 23, 51 );
        queerSnake.onmouseover = makeHandler( onSnakeMouseOver );

        key = makeArt( Assets.key, 71, 170, function() message( "The snake will not let you take the key." ) );
        key.style.display = "none";

        exit = makeArt( Assets.exitLeft, 8, 149, onExitClicked );
        exit.style.display = "none";

        dialog( [
            function()
            {
                line1.style.display = "none";
                queerSnakeDialog.textContent = "";
                line2.style.display = "block";
                vinnieDialog.textContent = "You must be the queer snake that the party-bots told me about.";
                playSound( Assets.vin1 );
            },

            function()
            {
                line1.style.display = "block";
                queerSnakeDialog.textContent = "Actually my brother is the queer one.";
                line2.style.display = "none";
                vinnieDialog.textContent = "";
                playSound( Assets.snake1 );
            },

            function()
            {
                line1.style.display = "none";
                queerSnakeDialog.textContent = "";
                line2.style.display = "block";
                vinnieDialog.textContent = "Where is he?";
                playSound( Assets.vin2 );
            },

            function()
            {
                line1.style.display = "block";
                queerSnakeDialog.textContent = "He went to Las Vegas for a gig.  He's bigger than Wayne Newton.";
                line2.style.display = "none";
                vinnieDialog.textContent = "";
                playSound( Assets.snake2 );
            },

            function()
            {
                line1.style.display = "none";
                queerSnakeDialog.textContent = "";
                line2.style.display = "block";
                vinnieDialog.textContent = "Very interesting.  I'm looking for a key to Vinnie's Tomb.";
                playSound( Assets.vin3 );
            },

            function()
            {
                line1.style.display = "block";
                queerSnakeDialog.textContent = "The key is with me.  I'm keeping it for him.  When he gets back from Vegas, he plans to find Vinnie's Tomb himself.";
                line2.style.display = "none";
                vinnieDialog.textContent = "";
                playSound( Assets.snake3 );
            },

            function()
            {
                line1.style.display = "none";
                queerSnakeDialog.textContent = "";
                line2.style.display = "block";
                vinnieDialog.textContent = "Would you consider selling or trading the key?";
                playSound( Assets.vin4 );
            },

            function()
            {
                line1.style.display = "block";
                queerSnakeDialog.textContent = "Sorry.  It belongs to my brother.  I cannot give it up without his permission.";
                line2.style.display = "none";
                vinnieDialog.textContent = "";
                playSound( Assets.snake4 );
            },

            function()
            {
                queerSnakeDialog.textContent = "";
                vinnieDialog.textContent = "";
                line1.style.display = "none";
                line2.style.display = "none";
                inventory.show();
                exit.style.display = "block";
                allowDragging = true;
            }
        ] );
    }

    function onExitClicked()
    {
        nextScene( Scene7 );
    }

    function onSnakeMouseOver()
    {
        if( exit.style.display == "block" )
        {
            if( isDraggingVinnie )
            {
                playSound( Assets.vin10, true ).then( function()
                    {
                        message( "Can I take a look at the key?" );
                        playSound( Assets.snake10, true ).then( function()
                            {
                                message( "I guess so." );
                                key.style.display = "block";
                                cancelDrag();
                            }
                        );
                    }
                );
            }
            else if( equippedItem != null )
            {
                switch( equippedItem.type )
                {
                    case Magnet:
                        playSound( Assets.vin6, true ).then( function() {
                            message( "Will you trade the key for this magnet?" );
                            playSound( Assets.snake5, true ).then( function() {
                                message( "That's a nifty magnet.  However, I don't think I need one.  The answer is no." );
                            } );
                        } );

                    case Diamond:
                        playSound( Assets.vin7, true ).then( function() {
                            message( "Will you trade the key for this diamond?" );
                            playSound( Assets.snake6, true ).then( function() {
                                message( "No.  Diamonds are worthless in Underworld.  Why do you think it was lying in the garbage?" );
                            } );
                        } );

                    case Banana:
                        playSound( Assets.vin8, true ).then( function() {
                            message( "Will you trade the key for this banana?" );
                            playSound( Assets.snake7, true ).then( function() {
                                message( "What do I look like?  I'm a snake, not a monkey." );
                            } );
                        } );

                    case SkullThatOozesBloodIntermittently:
                        playSound( Assets.vin9, true ).then( function() {
                            message( "Will you trade the key for this skull that oozes blood intermittently?" );
                            playSound( Assets.snake8, true ).then( function() {
                                message( "I vaguely recall my brother mentioning something about a skull.  I better not make the trade though." );
                            } );
                        } );

                    case Sword:
                        playSound( Assets.snake9, true ).then( function() {
                            message( "Are you threatening me?  Please go away before I lick you with my forked tongue." );
                        } );

                    case _:
                }

                equipItem( null );
            }
        }
    }

    var exit : Element;
    var key : Element;
    var queerSnake : Element;
    var queerSnakeDialog : Element;
    var vinnieDialog : Element;

}
