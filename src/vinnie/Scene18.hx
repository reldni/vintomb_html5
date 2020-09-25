package vinnie;

class Scene18 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 399;
        height = 187;
        title = "Scene 18";
        allowDragging = false;
    }

    public override function start()
    {
        super.start();

        audio.stopMusic();
        playSound( Assets.dragollater );

        makeArt( Assets.bgScene18, 0, 0 );

        var button = document.createButtonElement();
        button.style.position = "absolute";
        button.style.left = "288px";
        button.style.top = "152px";
        button.style.width = "105px";
        button.style.height = "29px";
        button.textContent = "End Game";
        button.style.fontFamily = '"MS Sans Serif,sans-serif';
        button.style.fontSize = "13.5pt";
        button.style.fontWeight = "bold";
        button.onclick = onEndGameClicked;
        mainView.appendChild( button );

        var text = makeDialogBox( 0, 8, width, 100, "yellow" );
        text.style.fontFamily = "Times New Roman,serif";
        text.style.fontSize = "24pt";
        text.style.fontWeight = "700";
        text.style.textAlign = "center";
        text.textContent = "TO BE CONTINUED";

        inventory.removeAllItems();
        inventory.show();
    }

    function onEndGameClicked()
    {
        playSound( Assets.death );
        message( "Thank you for playing Vinnie's Tomb.  Be sure to continue the adventure with Vinnie's Tomb Chapter Two - Shine and Glow Vinnie." );
        exitGame();
    }
}
