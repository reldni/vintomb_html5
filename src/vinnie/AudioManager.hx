package vinnie;
import haxe.Timer;
import js.Browser;
import js.html.Audio;
import vinnie.Assets;

/**
 * ...
 * @author The Behemoth
 */
class AudioManager
{
    public function new( game : Vinnie )
    {
        this.game = game;
        audios = new Map();
        audiosToPrime = new Array();

        Browser.window.onpagehide = onFocusChanged;
        Browser.window.onpageshow = onFocusChanged;
        Browser.document.addEventListener( "visibilitychange", onFocusChanged );
        audioPool = [for( i in 0...40 ) new Audio()];
        audiosToPrime = audioPool.copy();
    }

    var game : Vinnie;
    var audioPool : Array<Audio>;
    var audios : Map< String, Audio >;
    var audiosToPrime : Array<Audio>;

    var curSound : AudioHandle;
    var curMusic : AudioHandle;

    public function registerSound( sound : Sound )
    {
        if( !audios.exists( sound.id ) )
        {
            var dst = audioPool.pop();
            if( dst != null )
            {
                dst.src = sound.url;
                dst.autoplay = false;
                dst.load();
                dst.play();
                dst.pause();
                audios.set( sound.id, dst );
            }
        }
    }

    public function registerMusic( sound : Music )
    {
        if( !audios.exists( sound.id ) )
        {
            var dst = audioPool.pop();
            if( dst != null )
            {
                dst.src = sound.url;
                dst.autoplay = false;
                dst.load();

                audios.set( sound.id, dst );
            }
        }
    }

    public function playSound( sound : Sound, pause : Bool = false ) : AudioHandle
    {
        stopSound();

        var audio = audios.get( sound.id );
        if( audio == null )
        {
            audio = new Audio();
            audio.src = sound.url;
        }


        try { audio.currentTime = 0; } catch(e:Dynamic){}
        audio.volume = 1.0;
        audio.loop = false;
        audio.play();

        var handle = new AudioHandle( audio );
        curSound = handle;
        if( pause )
        {
            game.isPaused = true;
            handle.then( function() game.isPaused = false );
        }

        return handle;
    }

    public function playMusic( music : Music )
    {
        stopMusic();
        var audio = audios.get( music.id );
        if( audio == null )
        {
            audio = new Audio();
            audio.src = music.url;
        }
        audio.loop = true;
        audio.volume = 1.0;
        try { audio.currentTime = 0; } catch(e:Dynamic){}
        audio.play();
        curMusic = new AudioHandle( audio );
    }

    public function stopSound()
    {
        if( curSound != null )
        {
            curSound.stop();
        }
        curSound = null;
    }

    public function stopMusic()
    {
        if( curMusic != null )
        {
            curMusic.stop();
            curMusic = null;
        }
    }

    public function unregisterAll()
    {
        for( audio in audios )
        {
            if( audio != null )
            {
                if( audio.loop ) audio.pause();
                audioPool.push( audio );
            }
        }
        audios = new Map();
    }

    function onFocusChanged( _ )
    {
        if( curMusic != null )
        {
            if( Browser.document.hidden )
            {
                curMusic.pause();
            }
            else
            {
                curMusic.resume();
            }
        }
    }

    public function primeSounds( )
    {
        for( audio in audiosToPrime )
        {
            audio.volume = 0.0;
            audio.play();
            audio.pause();
        }
        if( audiosToPrime.length > 0 )
            audiosToPrime.splice( 0, audiosToPrime.length );
    }
}

private class AudioHandle
{
    public function new( audio : Audio )
    {
        this.audio = audio;
        onComplete = function() { audio.onended = null; };
        audio.onended = audio.onerror = function(_) onComplete();

        if( audio.error != null )
        {
            haxe.Timer.delay( function() { onComplete(); }, 1);
        }
    }

    public function then( f : Void->Void ) : AudioHandle
    {
        var oldOnComplete = onComplete;
        onComplete = function() { oldOnComplete(); f(); }
        return this;
    }

    public function stop()
    {
        audio.pause();
    }

    public function pause()
    {
        audio.pause();
    }

    public function resume()
    {
        audio.play();
    }

    var owner : AudioManager;
    var audio : Audio;
    var onComplete : Void->Void;
}
