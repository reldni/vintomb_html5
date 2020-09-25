package vinnie;
import haxe.Timer;
import js.Browser;
import js.html.ButtonElement;
import js.html.Element;

class Vinnie
{
    public static inline var EXIT_URL = "http://www.reldni.com";

    public static function main()
    {
        new Vinnie();
    }

    public function new()
    {
        var body = Browser.document.body;
        body.style.margin = "0";
        body.style.padding = "0";
        body.style.overflow = "hidden";
        body.style.position = "aboslute";
        body.style.width = "100%";
        body.style.height = "100%";
        body.style.backgroundColor = "#ffe0c0";
        body.style.setProperty( "-webkit-font-smoothing", "none" );
        body.style.setProperty( "font-smooth", "never" );
        body.style.setProperty( "-webkit-user-select", "none" );

        body.style.setProperty( "image-rendering", "optimizeSpeed" );
        body.style.setProperty( "image-rendering", "-moz-crisp-edges" );
        body.style.setProperty( "image-rendering", "-o-crisp-edges;" );
        body.style.setProperty( "image-rendering", "-webkit-optimize-contrast" );
        body.style.setProperty( "image-rendering", "optimize-contrast" );
        body.style.setProperty( "image-rendering", "pixelated" );
        body.style.setProperty( "-ms-interpolation-mode", "nearest-neighbor" );

        body.style.setProperty( "font-smooth", "never" );
        body.style.setProperty( "-webkit-user-select", "none" );

        body.style.setProperty( "user-select", "none" );
        body.ondragstart = function(_) return false;

        isMobile = ~/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/.match( Browser.navigator.userAgent );

        if( isMobile )
        {
            // Force scrollbar.
            var sheet = Browser.document.styleSheets[0];
            if( sheet == null )
            {
                var style = Browser.document.createStyleElement();
                style.type = "text/css";
                Browser.document.head.appendChild( style );
                sheet = style.sheet;
            }

            untyped if( untyped sheet.insertRule != null )
            {
                sheet.insertRule('::-webkit-scrollbar { -webkit-appearance: none; }', sheet.cssRules.length);
                sheet.insertRule('::-webkit-scrollbar:horizontal { height: 12px; }', sheet.cssRules.length);
                sheet.insertRule('::-webkit-scrollbar-thumb { background-color: rgba(0.5, 0.5, 0.5, .5); border: 2px solid #808080; }', sheet.cssRules.length);
                sheet.insertRule('::-webkit-scrollbar-track { background-color: #c0c0c0; }', sheet.cssRules.length);
            }
        }

        preloader = new Preloader( this);
        audio = new AudioManager( this );

        Browser.window.addEventListener( "resize", onResize );
        inventory = new Inventory( this );

        isPaused = false;
        bonusScenes = false;
        bonusSceneCompleted = new Array();
        shadesOn = false;
        primedAudio = false;

        loadingScreen = Browser.document.createDivElement();
        loadingScreen.style.position = "absolute";
        loadingScreen.style.left = "50%";
        loadingScreen.style.top = "50%";
        loadingScreen.style.width = "314px";
        loadingScreen.style.height = "81px";
        loadingScreen.style.color = "red";
        loadingScreen.style.textAlign = "center";
        loadingScreen.style.fontFamily = '"Times New Roman",serif';
        loadingScreen.style.fontSize = "20.25pt";
        loadingScreen.style.fontWeight = "700";
        loadingScreen.style.marginLeft = "-157px";
        loadingScreen.style.marginTop = "-40px";
        loadingScreen.style.textShadow = "-1px -1px black";
        loadingScreen.style.cursor = "default";
        loadingScreen.textContent = "Loading Vinnie's Tomb, Please Wait...";
        loadingScreen.style.zIndex = "10000";

        playButton = Browser.document.createButtonElement();
        playButton.textContent = "Play";
        playButton.style.position = "absolute";
        playButton.style.bottom = "0";
        playButton.style.width = "314px";
        playButton.style.height = "180px";
        playButton.style.fontSize = "30pt";
        playButton.style.display = "none";
        loadingScreen.appendChild( playButton );

        // Listen for F1.
        Browser.document.addEventListener( "keydown", onKeyDown );

        startScene( new MainMenu( this ) );
    }

    public function checkSceneLoaded( scene : Scene )
    {
        stopLoadingScreenTimer();
        loadingTimer = new Timer( 100 );
        loadingTimer.run = showLoadingScreen;

        preloader.onPreloadComplete = onPreloadComplete.bind( scene );
        scene.preload();
        preloader.beginPreload();
    }

    function preloadNextScene()
    {
        try
        {
            if( scene != null )
            {
                var nextSceneClass : Class<Scene>  = null;
                var className : String = null;
                if( Type.getClass( scene ) == MainMenu )
                {
                    nextSceneClass = Scene1;
                }
                else
                {
                    var sceneNum = Std.parseInt( Type.getClassName( Type.getClass( scene ) ).substr( "vinnie.Scene".length ) );
                    className = 'vinnie.Scene${sceneNum+1}';
                    nextSceneClass = cast Type.resolveClass( className );
                }

                if( nextSceneClass != null )
                {
                    var nextScene = Type.createInstance( nextSceneClass, [this] );
                    nextScene.preload();
                    preloader.beginPreload();
                }
            }
        }
    }

    public var preloader(default, null) : Preloader;
    public var scene(default, null) : Scene;
    public var audio(default, null) : AudioManager;
    public var inventory(default, null) : Inventory;
    public var isPaused(default, default) : Bool;
    public var isMobile(default, null) : Bool;
    public var bonusScenes : Bool;
    public var bonusSceneCompleted : Array<Bool>;
    public var shadesOn : Bool;

    var loadingTimer : Timer;
    var loadingScreen : Element;
    var playButton : ButtonElement;
    var primedAudio : Bool;

    public function startScene( scene : Scene )
    {
        var oldScene = this.scene;
        if( oldScene != null )
        {
            oldScene.end();
        }

        checkSceneLoaded( scene );
    }

    function onPreloadComplete( scene : Scene )
    {
        preloader.onPreloadComplete = null;

        if( isMobile && !primedAudio )
        {
            primedAudio = true;
            playButton.style.display = "block";
            playButton.onclick = function(_)
            {
                playButton.style.display = "none";
                audio.primeSounds();
                onSceneLoaded( scene );
            }
        }
        else
        {
            onSceneLoaded( scene );
        }
    }

    function onSceneLoaded( scene : Scene )
    {
        hideLoadingScreen();
        // Finally start it, and preload next scene.
        this.scene = scene;
        scene.start();
        preloadNextScene();
    }

    function onKeyDown( event )
    {
        var F1 = 112;
        if( event.keyCode == F1 )
        {
            help();
            return false;
        }

        return true;
    }

    public function help()
    {
        Browser.window.open( "manual/Vintomb.html", "_new" );
    }


    function showLoadingScreen()
    {
        if( loadingScreen.parentNode == null )
        {
            stopLoadingScreenTimer();
            Browser.document.body.appendChild( loadingScreen );
        }
    }

    function stopLoadingScreenTimer()
    {
        if( loadingTimer != null )
        {
            loadingTimer.stop();
            loadingTimer = null;
        }
    }

    function hideLoadingScreen()
    {
        stopLoadingScreenTimer();
        if( loadingScreen != null && loadingScreen.parentNode != null )
        {
            loadingScreen.parentNode.removeChild( loadingScreen );
        }
    }

    function onResize(_)
    {
        if( scene != null )
        {
            scene.updatePosition();
        }
    }
}