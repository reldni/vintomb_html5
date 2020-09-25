package vinnie;
import js.html.Element;
import js.html.ImageElement;

class Scene9 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 401;
        height = 216;
        title = "Scene Nine";
    }

    public override function start()
    {
        super.start();

        allowDragging = false;
        playMusic( Assets.musicScene9 );

        bg = makeArt( Assets.bgScene9, 0, 0 );

        makeHoverHotspot( 0, 0, 401, 137, cancelDrag );

        exit = makeArt( Assets.exitLeft, 0, 112, onExitClicked );
        exit.style.display = "none";

        line1 = makeArt( Assets.scene9Line1, 184, 40 );
        vinnieDialog = makeDialogBox( 192, 96, 201, 49, "black", "white" );
        vinnieDialog.style.fontWeight = "normal";
        makeItem( Shades, 216, 168 );
        makeVinnie( 312, 152 );
        horseDialog = makeDialogBox( 200, 8, 193, 81, "black", "white" );
        horseDialog.style.fontWeight = "normal";
        line2 = makeArt( Assets.scene9Line2, 264, 145 );

        /*
        function cutLines()
        {
            if( dialogLines.length >= 31 && curDialogLine >= 11 )
            {
                dialogLines.splice( 0, 11 );
            }
        }
        */
        function horseSpeak( sound, dialog )
        {
            vinnieDialog.style.display = "none";
            horseDialog.style.display = "block";
            horseDialog.textContent = dialog;
            line1.style.display = "block";
            line2.style.display = "none";
            playSound( sound );
            //cutLines();
        }
        function vinnieSpeak( sound, dialog )
        {
            vinnieDialog.style.display = "block";
            vinnieDialog.textContent = dialog;
            horseDialog.style.display = "none";
            line1.style.display = "none";
            line2.style.display = "block";
            playSound( sound );
            //cutLines();
        }

        dialog( [
            horseSpeak.bind( Assets.horse2, "Hello.  How are you this fine morning?" ),
            vinnieSpeak.bind( Assets.vin17, "Who is that?  I can’t see anyone there." ),
            horseSpeak.bind( Assets.horse2, "I’m an invisible horse." ),
            vinnieSpeak.bind( Assets.vin18, "Why are you invisible?" ),
            horseSpeak.bind( Assets.horse3, "The designer of this game can’t draw horses." ),
            vinnieSpeak.bind( Assets.vin19, "The designer can’t draw at all." ),
            horseSpeak.bind( Assets.horse4, "Would you like to see how I look?" ),
            vinnieSpeak.bind( Assets.vin20, "Not really, but go ahead." ),
            function()
            {
                horseSpeak( Assets.horse5, "What do you think?" );
                bg.src = Assets.bgScene9Visible.url;
            },
            vinnieSpeak.bind( Assets.vin21, "I think you should stay invisible." ),
            horseSpeak.bind( Assets.horse6, "I guess you’re right." ),
            vinnieSpeak.bind( Assets.vin22, "Do you know anything about Vinnie’s Tomb?" ),
            horseSpeak.bind( Assets.horse7, "According to legend it’s a tomb where a clown named Vinnie and his band of chickens were buried twelve centuries ago." ),
            vinnieSpeak.bind( Assets.vin23, "The legend is wrong.  There were no chickens." ),
            horseSpeak.bind( Assets.horse8, "Well, the chickens added some colour to the story." ),
            vinnieSpeak.bind( Assets.vin24, "I need the key to Vinnie’s tomb, but the snake will not part with it." ),
            horseSpeak.bind( Assets.horse9, "That does not matter.  I have a dozen keys to Vinnie’s tomb." ),
            vinnieSpeak.bind( Assets.vin25, "You do?" ),
            horseSpeak.bind( Assets.horse10, "Sure.  That fool snake and his queer lounge king brother think they have a monopoly on Vinnie’s Tomb keys.  They don’t know that I have amassed a collection of them along with expensive trinkets from the Franklin mint." ),
            vinnieSpeak.bind( Assets.vin26, "Would you please give me a key?" ),
            horseSpeak.bind( Assets.horse11, "I'll give you one for five hundred dollars." ),
            vinnieSpeak.bind( Assets.vin27, "I don’t have any money." ),
            horseSpeak.bind( Assets.horse12, "Then you better get a job." ),
            vinnieSpeak.bind( Assets.vin28, "Where can I find a job?" ),
            horseSpeak.bind( Assets.horse13, "There aren’t any jobs here in Fun Land." ),
            vinnieSpeak.bind( Assets.vin29, "This is most irritating." ),
            horseSpeak.bind( Assets.horse14, "Wait a minute.  There is a handsome reward out for the capture of that loud mouthed beast." ),
            vinnieSpeak.bind( Assets.vin30, "What loud mouthed beast?" ),
            horseSpeak.bind( Assets.horse15, "The one that keeps us all night singing 'Climb Every Mountain' and 'Can’t Help Lovin’ Dat Man'."),
            vinnieSpeak.bind( Assets.vin31, "I have heard of this monster already.  I guess I’ll have to find him." ),
            function()
            {
                horseSpeak( Assets.horse16, "Good luck.  You’re going to need it." );
                allowDragging = true;
                exit.style.display = "block";
            }
        ] );

        playSound( Assets.horse1 );
    }

    function onExitClicked()
    {
        nextScene( Scene10 );
    }

    var exit : Element;
    var horseDialog : Element;
    var vinnieDialog : Element;
    var line1 : Element;
    var line2 : Element;
    var bg : ImageElement;
}
