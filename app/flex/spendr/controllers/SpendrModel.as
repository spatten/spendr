package spendr.controllers {
  import org.restfulx.Rx;
  import org.restfulx.collections.ModelsCollection;
  import org.restfulx.events.CacheUpdateEvent;
  
  import spendr.models.Category;
  import spendr.models.Expenditure;
  import spendr.models.User;
  
  [Bindable]
  public class SpendrModel {
    private var _initialLoadCacheComplete:Boolean = false;
    
    public var currentUser:User;
    public var categories:ModelsCollection;
    public var expenditures:ModelsCollection;
    
    public function initialLoadCache():void {
      if (_initialLoadCacheComplete) return;
      _initialLoadCacheComplete = true;
      Rx.models.addEventListener(CacheUpdateEvent.ID, onCacheUpdate);
      Rx.models.index(User);
      Rx.models.index(Category);
      Rx.models.index(Expenditure);
    }
    

    private function onCacheUpdate(event:CacheUpdateEvent):void {
      //trace("SpendrModel#onCacheUpdate: " + event.fqn);
      if (event.isFor(User)) {
        trace("setting current User to " + Rx.models.cached(User)[0].email)
        currentUser = Rx.models.cached(User)[0];
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