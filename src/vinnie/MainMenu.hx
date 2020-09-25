package vinnie;
import js.html.ButtonElement;
import js.html.Element;
import js.html.HTMLDocument;
import js.html.ImageElement;
import js.html.InputElement;
import vinnie.Inventory.InventoryItemType;

/**
 * ...
 * @author The Behemoth
 */
class MainMenu extends Scene
{
    public static var PASSCODE_GAMES =
    [
        "ALVIN" => { scene: Scene3,  inventory: [Magnet, Sword], shades: false },
        "LALAL" => { scene: Scene8,  inventory: [Magnet, Sword, SkullThatOozesBloodIntermittently, Diamond, Banana], shades: false },
        "SETTA" => { scene: Scene12, inventory: [Magnet, Sword, SkullThatOozesBloodIntermittently, Diamond, Banana, ToolBox, CD, Underwear, Key, Cheese], shades: true },
        "METTA" => { scene: Scene12, inventory: [Magnet, Sword, SkullThatOozesBloodIntermittently, Diamond, Banana, ToolBox, EightBall, CD, Underwear, Key, Cheese], shades: true },
        "NETTA" => { scene: Scene12, inventory: [Magnet, Sword, SkullThatOozesBloodIntermittently, Diamond, Banana, ToolBox, CD, Underwear, Key, Cheese], shades: false },
        "RETTA" => { scene: Scene12, inventory: [Magnet, Sword, SkullThatOozesBloodIntermittently, Diamond, Banana, ToolBox, EightBall, CD, Underwear, Key, Cheese], shades: false },
    ];

    public function new( game : Vinnie )
    {
        super( game );
        width = 446;
        height = 347;
    }

    public override function start()
    {
        super.start();

        body.style.backgroundColor = "#ffe0c0";

        var menuDiv = document.createDivElement();
        menuDiv.style.margin = "0 auto";
        menuDiv.style.textAlign = "center";
        mainView.appendChild( menuDiv );

        var titleDiv = document.createDivElement();
        titleDiv.style.margin = "9px auto";
        titleDiv.style.position = "relative";
        menuDiv.appendChild( titleDiv );

        var img = document.createImageElement();
        img.src = Assets.title.url;
        img.style.display = "block";
        img.style.margin = "0 auto";
        titleDiv.appendChild( img );

        var subtitleDiv = document.createDivElement();
        subtitleDiv.style.position = "absolute";
        subtitleDiv.style.bottom = "5px";
        subtitleDiv.style.width = "100%";
        subtitleDiv.style.fontWeight = "bold";
        titleDiv.appendChild( subtitleDiv );

        var subtitleText = document.createSpanElement();
        subtitleText.style.fontSize = "120%";
        subtitleText.style.fontStyle = "italic";
        subtitleText.appendChild( document.createTextNode( "The Road to Vinnie's Tomb" ) );
        subtitleDiv.appendChild( subtitleText );

        subtitleDiv.appendChild( document.createBRElement() );

        var subtitleText = document.createSpanElement();
        subtitleText.appendChild( document.createTextNode( "(For Lack of A Better Title)" ) );
        subtitleDiv.appendChild( subtitleText );

        var button = makeButton( "Begin The Game" );
        button.style.margin = "2px auto 7px auto";
        button.style.width = "299px";
        button.style.height = "38px";
        var buttonHandler = makeHandler( function() game.startScene( new Scene1(game) ) );
        button.onclick = function(_) buttonHandler();
        menuDiv.appendChild( button );

        passCodeDiv = document.createDivElement();
        passCodeDiv.style.margin = "0 auto 33px auto";
        passCodeDiv.style.display = "block";
        menuDiv.appendChild( passCodeDiv );

        passCodeText = document.createInputElement();
        passCodeText.style.display = "none";
        passCodeText.style.width = "81px";
        passCodeText.style.height = "30px";
        passCodeText.style.float = "left";
        passCodeText.style.font = "Times New Roman";
        passCodeText.style.fontSize = "22px";
        passCodeText.style.textTransform = "uppercase";
        passCodeText.maxLength = 5;
        passCodeDiv.appendChild( passCodeText );

        passCodeButton = makeButton( "Enter Pass Code" );
        var buttonHandler2 = makeHandler( function() onEnterPassCodeClicked() );
        passCodeButton.onclick = buttonHandler2;
        passCodeButton.style.margin = "0 auto";
        passCodeButton.style.width = "299px";
        passCodeButton.style.height = "38px";
        passCodeDiv.appendChild( passCodeButton );

        var footer = document.createDivElement();
        footer.style.position = "absolute";
        footer.style.width = "100%";
        footer.style.height = "81px";
        footer.style.bottom = "0";
        footer.style.margin = "0";
        footer.style.padding = "0";
        footer.style.borderTop = "3px solid black";
        mainView.appendChild( footer );

        var helpDiv = document.createDivElement();
        helpDiv.style.float = "left";
        helpDiv.style.marginLeft = "12px";
        helpDiv.style.marginTop = "12px";
        footer.appendChild( helpDiv );

        var vinnie = document.createImageElement();
        vinnie.src = Assets.vinnieShades.url;
        vinnie.style.float = "left";
        vinnie.style.margin = "0 15px 0 0";
        helpDiv.appendChild( vinnie );

        var helpText = document.createDivElement();
        helpText.style.fontFamily = '"Times New Roman",serif';
        helpText.style.fontSize = "14.25pt";
        helpText.style.fontWeight = "400";
        helpText.style.width = "300px";
        helpText.appendChild( document.createTextNode( "Press F1 at anytime for help and information.") );
        helpText.onclick = function(_) game.help();
        helpDiv.appendChild( helpText );

        var versionText = document.createDivElement();
        versionText.appendChild( document.createTextNode( "Web Version") );
        versionText.style.textAlign = "right";
        versionText.style.position = "absolute";
        versionText.style.right = "0px";
        versionText.style.fontFamily = '"MS Sans Serif",sans-serif';
        versionText.style.fontSize = "13.5pt";
        versionText.style.fontWeight = "400";
        versionText.style.fontWeight = "700";
        versionText.style.marginRight = "12px";
        versionText.style.marginTop = "12px";
        footer.appendChild( versionText );

        var hotspot = makeClickHotspot( 13, 171, 39, 32, onLightBulb );
        hotspot.onmouseover = function(_) setCursor( Assets.lightBulb );
        hotspot.onmouseout = function(_) setCursor( null );

        lightBulbCount = 0;

        playMusic( Assets.musicIntro );
    }

    public override function end()
    {
        super.end();
    }

    var passCodeButton : ButtonElement;
    var passCodeDiv : Element;
    var passCodeText : InputElement;
    var lightBulbCount : Int;

    function onLightBulb()
    {
        message( "It's nice to see you again Fred.  How are the wife and kids?" );

        lightBulbCount++;

        if( lightBulbCount >= 6 )
        {
            audio.playSound( Assets.completeScene ).then( function ()
            {
                game.bonusScenes = true;
                message( "You now have access to the bonus scenes.  All you have to do is find them." );
            } );
        }
    }

    function makeButton( label : String )
    {
        var button = document.createButtonElement();
        button.appendChild( document.createTextNode( label ) );
        button.style.fontSize = "13.5pt";
        button.style.fontWeight = "400";
        button.style.fontFamily = '"MS Sans Serif",sans-serif';
        button.style.display = "block";
        return button;
    }

    function onEnterPassCodeClicked()
    {
        if( passCodeText.style.display == "none" )
        {
            passCodeDiv.style.width = "300px";
            passCodeDiv.style.height = "30px";
            passCodeDiv.style.border = "1px solid black";
            passCodeDiv.style.backgroundColor = "white";
            passCodeDiv.style.padding = "11px 7px";

            passCodeButton.style.width = "211px";
            passCodeButton.style.height = "30px";

            passCodeText.style.display = "block";
        }
        else
        {
            var passInfo = PASSCODE_GAMES.get( passCodeText.value.toUpperCase() );
            if( passInfo == null )
            {
                playSound( Assets.vin22, true ).then( function() message( "INVALID PASS CODE" ) );
            }
            else
            {
                 playSound( Assets.completeScene, true ).then(
                    function()
                    {
                        for( item in passInfo.inventory )
                        {
                            inventory.addItem( item );
                        }
                        game.shadesOn = passInfo.shades;
                        var scene = Type.createInstance( passInfo.scene, [game] );
                        scene.preload();
                        game.startScene( scene );
                    }
                );
            }
        }
    }



}