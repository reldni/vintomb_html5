package vinnie;
import js.html.Element;
import js.html.ImageElement;

class Scene10 extends Scene
{
    public function new( game : Vinnie )
    {
        super( game );

        width = 401;
        height = 216;
        title = "Scene Ten";
    }

    public override function start()
    {
        super.start();
        allowDragging = false;

        playMusic( Assets.musicScene3 );

        bg = makeArt( Assets.bgScene10, 0, 0 );

        makeHoverHotspot( 8, 24, 201, 177, onBeastHover );
        makeHoverHotspot( 0, 0, 401, 145, cancelDrag );

        cd = makeItem( CD, 200, 168 );
        cd.style.display = "none";
        vinnieLine = makeArt( Assets.scene10Line2, 295, 145 );
        vinnieDialog = makeDialogBox( 256, 80, 161, 65, "black", "white" );
        vinnieDialog.style.fontWeight = "normal";
        beastLine = makeArt( Assets.scene10Line1, 151, 72 );
        beastDialog = makeDialogBox( 168, 8, 225, 65, "black", "white" );
        beastDialog.style.fontWeight = "normal";
        makeVinnie( 312, 160 );

        function beastSpeak( sound, dialog )
        {
            vinnieLine.style.display = vinnieDialog.style.display = "none";
            beastLine.style.display = beastDialog.style.display = "block";
            beastDialog.textContent = dialog;
            if( sound != null )playSound( sound );
        }
        function vinnieSpeak( sound, dialog )
        {
            vinnieLine.style.display = vinnieDialog.style.display = "block";
            beastLine.style.display = beastDialog.style.display = "none";
            vinnieDialog.textContent = dialog;
            playSound( sound );
        }

        beastSpeak( null, "Zzzzzzzzzzzzzzzz" );

        exit = makeArt( Assets.exitLeft, 1, 154, onExitClicked );
        exit.style.display = "none";

        dialog( [
            function() { },
            vinnieSpeak.bind( Assets.vin32, "Excuse me?  Are you sleeping?" ),
            function()
            {
                beastSpeak( Assets.sing1, "I’m awake now, thanks to you." );
                bg.src = Assets.bgScene10Awake.url;
            },
            vinnieSpeak.bind( Assets.vin33, "You look very tired." ),
            beastSpeak.bind( Assets.sing2, "What do you expect?  I’ve been singing and dancing all night long." ),
            vinnieSpeak.bind( Assets.vin34, "Are you the monster that keeps everyone awake at night?" ),
            beastSpeak.bind( Assets.sing3, "Yes.  What are you going to do about it?" ),
            vinnieSpeak.bind( Assets.vin35, "It’s very rude of you to keep everyone in Fun Land up at night." ),
            beastSpeak.bind( Assets.sing4, "I don’t care.  It’s my nature to sing, dance and tell jokes at night." ),
            vinnieSpeak.bind( Assets.vin36, "Why?" ),
            beastSpeak.bind( Assets.sing5, "Why do you think?  I’m a nocturnal kind of beast." ),
            vinnieSpeak.bind( Assets.vin22, "Do you know anything about Vinnie's Tomb?" ),
            beastSpeak.bind( Assets.sing6, "Sure.  I wrote a song about it.  Do you want to hear it?" ),
            vinnieSpeak.bind( Assets.vin37, "I guess so." ),
            beastSpeak.bind( Assets.sing7, "Then leave me alone, and come back tonight.  I’ll sing it for you then." ),
            vinnieSpeak.bind( Assets.vin38, "I want to hear it now." ),
            function()
            {
                beastSpeak( Assets.sing8, "Listen, you little punk.  I’ve had about enough of you!  Wait a minute.  I’ll give you a CD of the song.  You can hear it anytime." );
                cd.style.display = "block";
            },
            vinnieSpeak.bind( Assets.vin40, "Thanks, but I don’t have a CD player." ),
            beastSpeak.bind( Assets.sing9, "That's tough.  Go away." ),
            function()
            {
                vinnieLine.style.display = vinnieDialog.style.display = "none";
                beastLine.style.display = beastDialog.style.display = "none";
                exit.style.display = "block";
                allowDragging = true;
                inventory.show();
            }
        ] );
    }

    function onBeastHover()
    {
        if( isEquipped( Sword ) )
        {
                playSound( Assets.sing11 );
                message( "Please don't hurt me.  I'll stop singing at night, if you leave me alone." );
                //nextScene( Scene10 );
                // TODO
                transitionToNextScene( Scene11,
                    function()
                    {
                        inventory.show();
                        inventory.addItem( Underwear );
                        inventory.addItem( Cheese );
                        playSound( Assets.nar3 );
                        message( "Word quickly spreads that you have stopped the beast from singing at night.  After everyone in Fun Land has a good night's sleep, they give you a load of cash and a nicely written thank you note.  You decide to use the money to buy the key from the ill conceived horse.  On the way to the horse's newly constructed hay shack and rib joint  you meet a frog on welfare.  Still feeling like a philanthropist, you foolishly give the frog most of our money.  Fortunately, you still have enough to buy a pair of underwear and cheese." );
                        inventory.addItem( Money );
                        playSound( Assets.nar4 );
                        message( "You decide to buy a lottery ticket with your last dollar.  Fun Land is a peachy place.  You find that the creatures there are really kind and decent.  You meet a monster snail who lets you stay at his hotel free of charge.  In the morning you are informed that the singing beast has moved to Australia.  He will be performing at the opera house one month a week.  You're glad he made out okay.  You are delighted when you win five hundred dollars in the lottery.  You rush to find the horse and buy the key." );
                    }
                );
        }
        else if( equippedItem != null )
        {
            playSound( Assets.sing10 );
            message( "I don't want that.  Get lost!" );
        }
    }

    function onExitClicked()
    {
        nextScene( Scene12 );
    }

    var bg : ImageElement;
    var exit : Element;
    var cd : Element;
    var vinnieLine : Element;
    var beastLine : Element;
    var vinnieDialog : Element;
    var beastDialog : Element;
}
