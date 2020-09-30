package vinnie;

abstract Art(String) from String
{
    public var id(get, never) : String;
    inline function get_id() return this;

    public var url(get, never) : String;
    inline function get_url() return 'assets/art/$id.gif';
}

abstract Sound(String) from String
{
    public var id(get, never) : String;
    inline function get_id() return this;

    public var url(get, never) : String;
    inline function get_url() return 'assets/sounds/$id';
}

abstract Music(String) from String
{
    public var id(get, never) : String;
    inline function get_id() return this;

    public var url(get, never) : String;
    inline function get_url() return 'assets/music/$id.mp3';
}

class Assets
{
    // Misc. Art
    public static var title           : Art       = "title";
    public static var lightBulb       : Art       = "light-bulb";
    public static var exitLeft        : Art       = "exit-left";
    public static var exitRight       : Art       = "exit-right";
    public static var bolt            : Art       = "bolt";
    public static var scene4Line1     : Art       = "scene4-line1";
    public static var scene4Line2     : Art       = "scene4-line2";
    public static var scene6Line1     : Art       = "scene6-line1";
    public static var scene6Line2     : Art       = "scene6-line2";
    public static var funLandEntrance : Art       = "fun-land-entrance";
    public static var scene7Line      : Art       = "scene7-line";
    public static var ufo             : Art       = "ufo";
    public static var scene8Line1     : Art       = "scene8-line1";
    public static var scene8Line2     : Art       = "scene8-line2";
    public static var scene9Line1     : Art       = "scene9-line1";
    public static var scene9Line2     : Art       = "scene9-line2";
    public static var scene10Line1    : Art       = "scene10-line1";
    public static var scene10Line2    : Art       = "scene10-line2";
    public static var book            : Art       = "book";
    public static var twig            : Art       = "twig";
    public static var slingshot       : Art       = "slingshot";
    public static var sphereOfLight   : Art       = "sphere-of-light";
    public static var bloodRockCover  : Art       = "blood-rock-cover";
    public static var scene14Line1    : Art       = "scene14-line1";
    public static var scene14Line2    : Art       = "scene14-line2";
    public static var scene17door     : Art       = "scene17-door";
    public static var cdBeam          : Art       = "cd-beam";

    // Bg Art
    public static var bgScene1        : Art       = "scene1";
    public static var bgScene2        : Art       = "scene2";
    public static var bgScene3        : Art       = "scene3";
    public static var bgScene6        : Art       = "scene6";
    public static var bgScene7        : Art       = "scene7";
    public static var bgScene8        : Art       = "scene8";
    public static var bgScene9        : Art       = "scene9";
    public static var bgScene9Visible : Art       = "scene9-visible";
    public static var bgScene10       : Art       = "scene10";
    public static var bgScene10Awake  : Art       = "scene10-awake";
    public static var bgScene12       : Art      = "scene12";
    public static var bgScene13       : Art      = "scene13";
    public static var bgScene14       : Art      = "scene14";
    public static var bgScene15       : Art      = "scene15";
    public static var bgScene16       : Art      = "scene16";
    public static var bgScene17       : Art      = "scene17";
    public static var bgScene18       : Art      = "scene18";
    public static var bgAction        : Art      = "action";

    // Character Art
    public static var sadEthel        : Art       = "sad-ethel";
    public static var partyBots       : Art       = "party-bots";
    public static var queerSnake      : Art       = "queer-snake";
    public static var funlander       : Art       = "funlander";
    public static var jerk            : Art       = "jerk";
    public static var eyeGuy          : Art       = "eye";

    // Vinnie Art
    public static var vinnie          : Art       = "vinnie";
    public static var vinnieShades    : Art       = "vinnie-shades";
    public static var vinnieDrown     : Art       = "vinnie-drown";
    public static var vinnieFried     : Art       = "vinnie-fried";

    // Inventory Art
    public static var magnet          : Art       = "magnet";
    public static var sword           : Art       = "sword";
    public static var skull           : Art       = "skull";
    public static var bloodySkull     : Art       = "skull-blood";
    public static var diamond         : Art       = "diamond";
    public static var banana          : Art       = "banana";
    public static var key             : Art       = "key";
    public static var underwear       : Art       = "underwear";
    public static var cd              : Art       = "cd";
    public static var money           : Art       = "money";
    public static var eightBall       : Art       = "8ball";
    public static var cheese          : Art       = "cheese";
    public static var shades          : Art       = "shades";
    public static var toolBox         : Art       = "toolbox";

    // Sounds
    public static var getItem         : Sound     = "hap1.mp3";
    public static var completeScene   : Sound     = "hap2.mp3";
    public static var eureka          : Sound     = "hap3.mp3";
    public static var death           : Sound     = "death.mp3";
    public static var teleport        : Sound     = "teleport.mp3";
    public static var trainWhistle    : Sound     = "WHI.MP3";
    public static var sphereZap       : Sound     = "elev.mp3";
    public static var dragollater     : Sound     = "SCREAM.MP3";

    // Justin Crybaby Dialog
    public static var narIntro        : Sound     = "INTRON.MP3";
    public static var nar1            : Sound     = "NAR1.MP3";
    public static var nar3            : Sound     = "NAR3.MP3";
    public static var nar4            : Sound     = "NAR4.MP3";

    // Vinnie Dialog
    public static var vin1            : Sound     = "Vin1.mp3";
    public static var vin2            : Sound     = "Vin2.mp3";
    public static var vin3            : Sound     = "Vin3.mp3";
    public static var vin4            : Sound     = "Vin4.mp3";
    public static var vin6            : Sound     = "vin6.mp3";
    public static var vin7            : Sound     = "Vin7.mp3";
    public static var vin8            : Sound     = "Vin8.mp3";
    public static var vin9            : Sound     = "Vin9.mp3";
    public static var vin10           : Sound     = "Vin10.mp3";
    public static var vin11           : Sound     = "Vin11.mp3";
    public static var vin12           : Sound     = "Vin12.mp3";
    public static var vin13           : Sound     = "Vin13.mp3";
    public static var vin14           : Sound     = "Vin14.mp3";
    public static var vin15           : Sound     = "Vin15.mp3";
    public static var vin16           : Sound     = "Vin16.mp3";
    public static var vin17           : Sound     = "Vin17.mp3";
    public static var vin18           : Sound     = "Vin18.mp3";
    public static var vin19           : Sound     = "Vin19.mp3";
    public static var vin20           : Sound     = "Vin20.mp3";
    public static var vin21           : Sound     = "Vin21.mp3";
    public static var vin22           : Sound     = "Vin22.mp3";
    public static var vin23           : Sound     = "Vin23.mp3";
    public static var vin24           : Sound     = "Vin24.mp3";
    public static var vin25           : Sound     = "Vin25.mp3";
    public static var vin26           : Sound     = "Vin26.mp3";
    public static var vin27           : Sound     = "Vin27.mp3";
    public static var vin28           : Sound     = "Vin28.mp3";
    public static var vin29           : Sound     = "Vin29.mp3";
    public static var vin30           : Sound     = "Vin30.mp3";
    public static var vin31           : Sound     = "Vin31.mp3";
    public static var vin32           : Sound     = "Vin32.mp3";
    public static var vin33           : Sound     = "Vin33.mp3";
    public static var vin34           : Sound     = "Vin34.mp3";
    public static var vin35           : Sound     = "Vin35.mp3";
    public static var vin36           : Sound     = "Vin36.mp3";
    public static var vin37           : Sound     = "Vin37.mp3";
    public static var vin38           : Sound     = "Vin38.mp3";
    public static var vin40           : Sound     = "Vin40.mp3";
    public static var vin41           : Sound     = "Vin41.mp3";
    public static var vin42           : Sound     = "Vin42.mp3";
    public static var vin44           : Sound     = "Vin44.mp3";

    // Party-Bots Dialog
    public static var partyBots1      : Sound     = "Bot1.mp3";
    public static var partyBots2      : Sound     = "bot2.mp3";
    public static var partyBots3      : Sound     = "bot3.mp3";

    // Snake Dialog
    public static var snake1          : Sound     = "snake1.mp3";
    public static var snake2          : Sound     = "snake2.mp3";
    public static var snake3          : Sound     = "snake3.mp3";
    public static var snake4          : Sound     = "snake4.mp3";
    public static var snake5          : Sound     = "snake5.mp3";
    public static var snake6          : Sound     = "snake6.mp3";
    public static var snake7          : Sound     = "snake7.mp3";
    public static var snake8          : Sound     = "snake8.mp3";
    public static var snake9          : Sound     = "snake9.mp3";
    public static var snake10         : Sound     = "snake10.mp3";

    // Fun Lander Dialog
    public static var guy1            : Sound     = "guy1.mp3";
    public static var guy2            : Sound     = "guy2.mp3";
    public static var guy3            : Sound     = "guy3.mp3";
    public static var guy4            : Sound     = "guy4.mp3";
    public static var guy5            : Sound     = "guy5.mp3";

    // Horse Dialog
    public static var horse1          : Sound     = "horse1.mp3";
    public static var horse2          : Sound     = "horse2.mp3";
    public static var horse3          : Sound     = "horse3.mp3";
    public static var horse4          : Sound     = "horse4.mp3";
    public static var horse5          : Sound     = "horse5.mp3";
    public static var horse6          : Sound     = "horse6.mp3";
    public static var horse7          : Sound     = "horse7.mp3";
    public static var horse8          : Sound     = "horse8.mp3";
    public static var horse9          : Sound     = "horse9.mp3";
    public static var horse10         : Sound     = "horse10.mp3";
    public static var horse11         : Sound     = "horse11.mp3";
    public static var horse12         : Sound     = "horse12.mp3";
    public static var horse13         : Sound     = "horse13.mp3";
    public static var horse14         : Sound     = "horse14.mp3";
    public static var horse15         : Sound     = "horse15.mp3";
    public static var horse16         : Sound     = "horse16.mp3";

    // Singing Beast Dialog
    public static var sing1           : Sound     = "SING1.MP3";
    public static var sing2           : Sound     = "SING2.MP3";
    public static var sing3           : Sound     = "SING3.MP3";
    public static var sing4           : Sound     = "SING4.MP3";
    public static var sing5           : Sound     = "SING5.MP3";
    public static var sing6           : Sound     = "SING6.MP3";
    public static var sing7           : Sound     = "SING7.MP3";
    public static var sing8           : Sound     = "SING8.MP3";
    public static var sing9           : Sound     = "SING9.MP3";
    public static var sing10          : Sound     = "SING10.MP3";
    public static var sing11          : Sound     = "SING11.MP3";

    // Eye Guy Dialog
    public static var eye1            : Sound     = "EYE1.MP3";
    public static var eye2            : Sound     = "EYE2.MP3";
    public static var eye3            : Sound     = "EYE3.MP3";


    // Music
    public static var musicIntro      : Music     = "intro";
    public static var musicScene1     : Music     = "scene1";
    public static var musicScene2     : Music     = "scene2";
    public static var musicScene3     : Music     = "scene3";
    public static var musicScene4     : Music     = "scene4";
    public static var musicScene5     : Music     = "scene5";
    public static var musicScene6     : Music     = "scene6";
    public static var musicScene7     : Music     = "scene7";
    public static var musicScene8     : Music     = "scene8";
    public static var musicScene9     : Music     = "scene9";
    public static var musicScene10    : Music     = "scene10";
}