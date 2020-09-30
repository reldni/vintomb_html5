package vinnie;
import js.html.Element;
import js.html.Text;

class Scene4 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 377;
        height = 200;
        title = "Scene Four";
        allowDragging = false;
    }

    public override function start()
    {
        super.start();

        playMusic( Assets.musicScene4 );

        mainView.style.backgroundColor = "black";
        makeArt( Assets.partyBots, 270, 48 );
        makeArt( Assets.scene4Line1, 87, 95 );
        makeArt( Assets.scene4Line2, 239, 39 );
        makeVinnie( 72, 136 );

        partyBotsDialog = makeDialogBox( 8, 8, 353, 33, "white" );
        vinnieDialog = makeDialogBox( 8, 56, 169, 49, "white" );

        function speak( sound, partyBotsMsg, vinnieMsg )
        {
            vinnieDialog.textContent = vinnieMsg;
            partyBotsDialog.textContent = partyBotsMsg;
            playSound( sound );
        }

        var scrollContainer = dialog( [
            speak.bind(
                Assets.partyBots1,
                "Welcome to the Underworld!  You can get keen bargains on assorted undergarments.",
                "That sounds just fine.  I'm trying to find the key to Vinnie's tomb.  Can you help?"
            ),
            speak.bind(
                Assets.partyBots2,
                "The key is hidden to have been hidden with the ancient Tibetan handkerchief.",
                "Where should I start looking?"
            ),
            function()
            {
                speak(
                    Assets.partyBots3,
                    "There's an old queer snake who lives in a pile of garbage.  He may be able to help.  He's not far from here.",
                    "Thank you.  I'll try to find him."
                );
                if( exit == null )
                    exit = makeArt( Assets.exitLeft, 8, 136, onExitClicked );
            }
        ] );

        scrollContainer.style.width = '${width-8}px';
        scrollContainer.style.border = "5px ridge white";
        scrollContainer.style.height = '22px';
        scrollContainer.style.background = "#c0c0c0";
        dialogScroller.style.width = '${width-16}px';
        dialogScroller.style.top = "2px";
        dialogScroller.style.left = "3px";
    }

    function onExitClicked()
    {
        nextScene( Scene5 );
    }

    var partyBotsDialog : Element;
    var vinnieDialog : Element;
    var exit : Element;
}