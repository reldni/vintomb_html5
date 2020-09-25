package vinnie;
import js.Browser;
import js.html.Audio;
import js.html.Element;
import js.html.Image;
import vinnie.Assets;

class Preloader
{
    public function new( game : Vinnie )
    {
        this.game = game;
        preloadedAssets = new Map();
        requestQueue = new Array();
        isPreloading = false;

        image = new Image();
        audio = new Audio();
    }

    public function preloadArt( art : Art )
    {
        addPreloadRequest( Image(art.url) );
    }

    public function preloadSound( sound : Sound )
    {
        addPreloadRequest( Audio( sound.url, sound.id ) );
    }

    public function preloadMusic( sound : Music )
    {
        addPreloadRequest( Audio( sound.url, sound.id ) );
    }

    public function beginPreload()
    {
        if( curRequest == null )
        {
            preloadNextAsset();
        }
    }

    function addPreloadRequest( request : PreloadRequest )
    {
        var url = switch( request )
        {
            case Audio( url, _ ): url;
            case Image( url ): url;
        }

        if( preloadedAssets.exists( url ) )
        {
            return;
        }

        preloadedAssets.set( url, true );
        requestQueue.push( request );
        isPreloading = true;
    }


    function preloadNextAsset()
    {
        if( requestQueue.length > 0 )
        {
            curRequest = requestQueue.pop();
            switch( curRequest )
            {
                case Audio( url, _ ):
                    audio.autoplay = false;
                    audio.oncanplaythrough = onAssetLoaded;
                    audio.onerror = onAssetLoaded;
                    audio.src = url;
                    audio.load();


                case Image( url ):
                    image.src = url;
                    image.onload = onAssetLoaded;
                    image.onerror = onAssetLoaded;
            }
        }
        else
        {
            curRequest = null;
        }

        if( requestQueue.length == 0 || curRequest == null )
        {
            isPreloading = false;
            haxe.Timer.delay( function() if( !isPreloading && onPreloadComplete != null ) onPreloadComplete(), 1 );
        }
    }

    function onAssetLoaded( e )
    {
        if( curRequest != null )
        {
            switch( curRequest )
            {
                case Audio( _, id ):
                    audio.onerror = null;
                    audio.oncanplaythrough = null;

                case Image(_):
                    image.onload = null;
                    image.onerror = null;

            }
        }

        preloadNextAsset();
    }

    var game(default, null) : Vinnie;

    var requestQueue : Array<PreloadRequest>;
    var curRequest : PreloadRequest;
    var audio : Audio;
    var image : Image;

    var preloadedAssets : Map<String, Bool>;

    public var isPreloading : Bool;
    public var onPreloadComplete : Void->Void;
}

private enum PreloadRequest
{
    Image( url : String );
    Audio( url : String, id : String );
}
