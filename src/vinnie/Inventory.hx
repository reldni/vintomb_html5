package vinnie;
import js.Browser;
import js.html.DivElement;
import js.html.Element;
import vinnie.Assets;

enum InventoryItemType
{
    Magnet;
    Sword;
    SkullThatOozesBloodIntermittently;
    Diamond;
    Banana;
    Key;
    Underwear;
    CD;
    Money;
    EightBall;
    Cheese;
    Shades;
    ToolBox;
}

typedef InventoryItem =
{
    var type : InventoryItemType;
    var name : String;
    var icon : Art;
    var x : Int;
    var y : Int;
}

class Inventory
{
    public static var itemInfo : Map<InventoryItemType, InventoryItem> = [
        Magnet =>    { type: Magnet,     name: "a magnet",              icon: Assets.magnet,       x: 0,   y: 8 },
        Sword =>     { type: Sword,      name: "a sword",               icon: Assets.sword,        x: 40,  y: 8 },
        SkullThatOozesBloodIntermittently =>  { type:   SkullThatOozesBloodIntermittently,      name: "the skull that oozes blood intermittently.", icon: Assets.skull, x: 80, y: 8 },
        Diamond =>   { type: Diamond,    name: "the glittery diamond.", icon: Assets.diamond,      x: 112, y: 8  },
        Banana =>    { type: Banana,     name: "an overripe banana.",   icon: Assets.banana,       x: 144, y: 8  },
        Key =>       { type: Key,        name: "key.",                  icon: Assets.key,          x: 176, y: 48 },
        Underwear => { type: Underwear,  name: "underwear.",            icon: Assets.underwear,    x: 136, y: 48 },
        CD =>        { type: CD,         name: "a the compact disc.",   icon: Assets.cd,           x: 96,  y: 48 },
        Money =>     { type: Money,      name: "money.",                icon: Assets.money,        x: 48,  y: 40 },
        EightBall => { type: EightBall,  name: "8-ball.",               icon: Assets.eightBall,    x: 8,   y: 48 },
        Cheese =>    { type: Cheese,     name: "cheese.",               icon: Assets.cheese,       x: 216, y: 40 },
        Shades =>    { type: Shades,     name: "a pair of cool shades.  You wonder why you keep finding things just lying around.",               icon: Assets.shades,       x: 232, y: 8  },
        ToolBox =>   { type: ToolBox,    name: "a metal box.",          icon: Assets.toolBox,      x: 192, y: 8  },
        //VinnieWithShades =>   { type: VinnieWithShades ,    name: "VinnieWithShades.",              icon: Assets.vinnieShades,      x: 352, y: 3  },
    ];

    public function new( game : Vinnie )
    {
        this.game = game;

        inventoryView = Browser.document.createDivElement();
        inventoryView.style.position = "absolute";
        inventoryView.style.top = "50%";
        inventoryView.style.left = "50%";
        inventoryView.style.display = "none";
        inventoryView.style.background = "#ffe0c0";
        inventoryView.style.zIndex = "10001";

        var w = 270;
        var h = 120;
        inventoryView.style.width = '${w}px';
        inventoryView.style.height = '${h}px';
        inventoryView.style.marginLeft = '-${w/2}px';
        inventoryView.style.border = "1px solid black";
        inventoryView.style.overflow = "hidden";
        Browser.document.body.appendChild( inventoryView );

        var titleBar = Browser.document.createDivElement();
        titleBar.style.background = "#000080";
        titleBar.style.color = "white";
        titleBar.style.fontSize = "8.5pt";
        titleBar.style.width = "100%";
        titleBar.style.padding = "4px 2px";
        titleBar.style.fontFamily = '"MS Sans Serif",sans-serif';
        titleBar.style.fontWeight = "bold";
        titleBar.style.cursor = "default";
        titleBar.appendChild( Browser.document.createTextNode( "Item Inventory" ) );
        titleBar.onclick = onTitleBarClicked;
        inventoryView.appendChild( titleBar );

        useCollapse = false;
        isCollapsed = false;

        items = new Map();
    }

    public function show()
    {
        inventoryView.style.display = "block";
        resetPosition();
    }

    public function hide()
    {
        inventoryView.style.display = "none";
    }

    public function hasItem( item : InventoryItemType )
    {
        return items.exists( item );
    }

    public function addItem( item : InventoryItemType )
    {
        var itemInfo = itemInfo.get( item );
        if( itemInfo != null )
        {
            var itemPic = Browser.document.createImageElement();
            itemPic.src = itemInfo.icon.url;
            itemPic.style.position = "absolute";
            itemPic.style.left = '${itemInfo.x+2}px';
            itemPic.style.top = '${itemInfo.y+16}px';
            itemPic.onclick = onEquipItem.bind( itemInfo );
            itemPic.addEventListener( "touchstart", function(_) { onEquipItem.bind( itemInfo )(); } );
            inventoryView.appendChild( itemPic );

            items.set( item, itemPic );
        }
    }

    public function resetPosition()
    {
        if( game.scene != null )
        {
            var viewRect = game.scene.getViewRect();

            var height = 120;
            var yPos = viewRect.top - height - 4;
            if( yPos < 0 )
            {
                yPos = 0;
                useCollapse = true;
                isCollapsed = true;
                height = 20;
            }
            else
            {
                useCollapse = false;
                isCollapsed = false;
            }

            inventoryView.style.top = '${yPos}px';
            inventoryView.style.height = '${height}px';
        }
    }

    public function removeItem( item : InventoryItemType )
    {
        var itemPic = items.get( item );
        if( itemPic != null && itemPic.parentNode != null )
        {
            itemPic.parentNode.removeChild( itemPic );
        }
        items.remove( item );
    }

    public function removeAllItems()
    {
        for( itemPic in items )
        {
            if( itemPic != null && itemPic.parentNode != null )
            {
                itemPic.parentNode.removeChild( itemPic );
            }
        }
        items = new Map();
    }

    function onEquipItem( item : InventoryItem )
    {
        if( game.scene == null )
        {
            return;
        }

        if( item.type == ToolBox )
        {
            if( !hasItem( EightBall ) )
            {
                game.scene.message( "You find an eight ball inside the metal box." ).then( function() {
                    addItem( EightBall );
                } );
            }
            else
            {
                game.scene.message( "The Metal Box is empty." );
            }
        }
        else if( item.type == EightBall && Type.getClass( game.scene ) != Scene13 )
        {
            game.scene.message( "You do not need the eight ball in this scene" );
        }
        else if( item.type == CD && Type.getClass( game.scene ) != Scene17 )
        {
            game.scene.message( "You do not have a CD player to play the disc" );
        }
        else if( item.type == Shades )
        {
            game.shadesOn = true;
            removeItem( Shades );
            game.scene.message( "You put on the cool shades." ).then( function() {
                game.scene.wearShades();
            } );
        }
        else
        {
            game.scene.equipItem( item );
        }

        onCollapseInventory( null );
    }

    public function preloadItems()
    {
        for( item in itemInfo )
        {
            game.preloader.preloadArt( item.icon );
        }
    }

    function onTitleBarClicked(_)
    {
        if( useCollapse )
        {
            inventoryView.addEventListener( "mouseleave", onCollapseInventory );
            inventoryView.style.height = "120px";
            isCollapsed = true;
        }
    }

    function onCollapseInventory(_)
    {
        inventoryView.removeEventListener( "mouseleave", onCollapseInventory );
        if( useCollapse )
        {
            inventoryView.style.height = "20px";
            isCollapsed = false;
        }
    }

    var game : Vinnie;
    var inventoryView : DivElement;
    var items : Map< InventoryItemType, Element >;

    var useCollapse : Bool;
    var isCollapsed : Bool;
}