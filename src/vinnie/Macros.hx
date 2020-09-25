package vinnie;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.Function;
import haxe.macro.ExprTools;

class Macros
{
    public static function buildScene()
    {
        var fields = Context.getBuildFields();
        var assets = [];
        var registerSounds = [];
        for( field in fields )
        {
            switch( field.kind )
            {
                case FFun(f):
                    getAssetsUsed( f, assets, registerSounds );

                case _:
            }
        }

        if( assets.length > 0 )
        {
            fields.push( (macro class F {
                public override function preload()
                {
                    super.preload();
                    $b{assets};
                }
            }).fields[0] );

            fields.push( (macro class F {
                public override function registerSounds()
                {
                    super.registerSounds();
                    $b{registerSounds};
                }
            }).fields[0] );
        }

        return fields;
    }

    static function getAssetsUsed( f : Function, assets : Array<Expr>, registerSounds : Array<Expr> )
    {
        function findAssets( e : Expr )
        {
            switch( e )
            {
                case macro Assets.$assetName:
                    var t = Context.toComplexType( Context.typeof( e ) );
                    switch( t )
                    {
                        case macro : vinnie.Assets.Art:
                            assets.push( macro game.preloader.preloadArt( Assets.$assetName ) );

                        case macro : vinnie.Assets.Sound:
                            assets.push( macro game.preloader.preloadSound( Assets.$assetName ) );
                            registerSounds.push( macro audio.registerSound( Assets.$assetName ) );

                        case macro : vinnie.Assets.Music:
                            assets.push( macro game.preloader.preloadMusic( Assets.$assetName ) );
                            registerSounds.push( macro audio.registerMusic( Assets.$assetName ) );

                        case _:
                    }

                case _:
                    ExprTools.iter( e, findAssets );
            }
        }

        ExprTools.iter( f.expr, findAssets );
    }

}