package;

@:native("Newgrounds.io.core") extern class NewgroundsIo {
  public function new(appId: String, aesEncryptionKey:String);

  /**
    Get the HTML contents of the first element in the set of matched elements.
    OR
    Set the HTML contents of each element in the set of matched elements.
  **/
  public function getValidSession( ?callback: Void->Void, ?context: Dynamic ): Void;
  public function callComponent( component: String, parameters: Dynamic, ?callback: Dynamic->Void, ?context : Dynamic ): Void;
  public function queueComponent( component: String, parameters: Dynamic, ?callback: Dynamic->Void, ?context : Dynamic ): Void;
  public function executeQueue(): Void;

  public var user: Dynamic;
  public var debug: Bool;
}