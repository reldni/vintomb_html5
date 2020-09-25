package vinnie;
import js.html.Element;

class Scene8 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 400;
        height = 218;
        title = "Scene Eight";

    }

    public override function start()
    {
        super.start();

        allowDragging = false;

        playMusic( Assets.musicScene8 );

        makeArt( Assets.bgScene8, 0, 0 );
        makeHoverHotspot( -1, 21, 401, 107, cancelDrag );

        line2 = makeArt( Assets.scene8Line2, 274, 123 );

        vinnieDialog = makeDialogBox( 209, 67, 171, 56, "black", "white" );
        vinnieDialog.style.fontFamily = '"Times New Roman",serif';
        vinnieDialog.style.fontSize = "9.75pt";
        vinnieDialog.style.fontWeight = "400";

        exit = makeArt( Assets.exitLeft, 8, 160, onExitClicked );
        exit.style.display = "none";

        makeVinnie( 349, 162 );

        guysDialog = makeDialogBox( 12, 49, 191, 56, "black", "white" );
        guysDialog.style.fontFamily = '"Times New Roman",serif';
        guysDialog.style.fontSize = "9.75pt";
        guysDialog.style.fontWeight = "normal";
        line1 = makeArt( Assets.scene8Line1, 69, 105 );

        makeItem( ToolBox, 296, 170 );

        makeArt( Assets.funlander, 176, 164 );
        makeArt( Assets.funlander, 138, 163 );
        makeArt( Assets.funlander, 106, 165 );
        makeArt( Assets.funlander, 75, 164 );

        makeArt( Assets.ufo, 322, -8, function() message( "The alien space ship is suspended high in the sky above Fun Land." ) );

        function vinnieSpeak( sound, dialog )
        {
            vinnieDialog.style.display = "block";
            vinnieDialog.textContent = dialog;
            guysDialog.style.display = "none";
            line1.style.display = "none";
            line2.style.display = "block";
            playSound( sound );
        }
        function guysSpeak( sound, dialog )
        {
            vinnieDialog.style.display = "none";
            guysDialog.style.display = "block";
            guysDialog.textContent = dialog;
            line1.style.display = "block";
            line2.style.display = "none";
            playSound( sound );
        }

        dialog( [
            vinnieSpeak.bind( Assets.vin11, "Why do you guys look so sad?  I thought this place was Fun Land." ),
            guysSpeak.bind( Assets.guy1, "That is the cruel irony." ),
            vinnieSpeak.bind( Assets.vin12, "Why are you so sad?" ),
            guysSpeak.bind( Assets.guy2, "We just found out that Donny Osmond canceled his gig here.  That’s only part of it though." ),
            vinnieSpeak.bind( Assets.vin13, "Tell me more." ),
            guysSpeak.bind( Assets.guy3, "There is a monster that terrorizes us through the night." ),
            vinnieSpeak.bind( Assets.vin14, "That’s terrible!  Does he try and eat you?" ),
            guysSpeak.bind( Assets.guy4, "No.  He tells horrible one liners and sings show tunes." ),
            vinnieSpeak.bind( Assets.vin15, "That doesn’t seem too bad." ),
            guysSpeak.bind( Assets.guy5, "He sounds like Leonard Cohen and he sings at three o’clock in the morning." ),
            vinnieSpeak.bind( Assets.vin16, "That is bad." ),
            function()
            {
                exit.style.display = "block";
                vinnieDialog.style.display = "none";
                guysDialog.style.display = "none";
                line1.style.display = "none";
                line2.style.display = "none";
                allowDragging = true;
                message( "You would like to ask the sad guys about Vinnie’s Tomb, but they appear too upset to answer any questions." );
            }
        ] );
    }

    function onExitClicked()
    {
        nextScene( Scene9 );
    }

    var line1 : Element;
    var line2 : Element;
    var guysDialog : Element;
    var vinnieDialog : Element;
    var exit : Element;
}
