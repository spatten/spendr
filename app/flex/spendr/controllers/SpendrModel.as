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
    
    private function sumExpendituresOverCategories():void {
      for (var c:int = 0 ; c < categories.length ; c++) {
        var category:Category = categories[c];
        category.expenditureSum = 0;
        if (category.expenditures) { // we don't know if we have both categories and expenditures yet, so check
          for (var e:int = 0 ; e < category.expenditures.length; e++)  {
            category.expenditureSum += category.expenditures[e].amount;
          }
        }
        trace(category.name + " expenditures = " + category.expenditureSum);
      }
    }
    

    private function onCacheUpdate(event:CacheUpdateEvent):void {
      //trace("SpendrModel#onCacheUpdate: " + event.fqn);
      if (event.isFor(User)) {
        trace("setting current User to " + Rx.models.cached(User)[0].email)
        currentUser = Rx.models.cached(User)[0];
      } else if (event.isFor(Category)) {
        categories = Rx.models.cached(Category);
        sumExpendituresOverCategories();
      } else if (event.isFor(Expenditure)) {
        expenditures = Rx.models.cached(Expenditure);
        sumExpendituresOverCategories();
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