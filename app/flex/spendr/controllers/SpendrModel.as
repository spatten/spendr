package spendr.controllers {
  import spendr.models.Category;
  import spendr.models.Expenditure;
  import spendr.models.User

  import mx.collections.ArrayCollection;
  import mx.collections.XMLListCollection;
  
  import org.restfulx.Rx;
  import org.restfulx.events.CacheUpdateEvent;
  import org.restfulx.collections.ModelsCollection;
  
  [Bindable]
  public class SpendrModel {
    public var currentUser:User;
    public var categories:ModelsCollection;
    public var expenditures:ModelsCollection;

    private function onCacheUpdate(event:CacheUpdateEvent):void {
      //trace("SpendrModel#onCacheUpdate: " + event.fqn);
      if (event.isFor(User)) {
        currentUser = Rx.models.cached(User).first;
      }
    }
  
    //
    //Singleton stuff
    //
    private static var _instance:SpendrModel;

    public static function get instance():SpendrModel {
      if (_instance == null) {
        _instance = new SpendrModel(new SingletonEnforcer);
      }
      return _instance;
    }
    
    public function SpendrModel(enforcer:SingletonEnforcer) {
    }
  }
}

class SingletonEnforcer {}