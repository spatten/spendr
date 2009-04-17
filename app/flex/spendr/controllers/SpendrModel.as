package spendr.controllers {
  import mx.formatters.CurrencyFormatter;
  import mx.core.Application;
  
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
    private var currencyFormatter:CurrencyFormatter;
    
    public function initialLoadCache():void {
      if (_initialLoadCacheComplete) return;
      _initialLoadCacheComplete = true;
      setupCurrencyFormatter();
      Rx.models.addEventListener(CacheUpdateEvent.ID, onCacheUpdate);
      var _user:User = new User;
      _user.id = Application.application.parameters.current_user_id;
      _user.show({onSuccess: onCurrentUserShow})
    }
    
    private function onCurrentUserShow(result:Object):void {
      currentUser = result as User;
    }
    
    private function setupCurrencyFormatter():void {
      currencyFormatter = new CurrencyFormatter;
      currencyFormatter.precision = 2;
      currencyFormatter.useThousandsSeparator = true;
      currencyFormatter.currencySymbol = "$";
    }
    
    public function formattedCents(cents:int):String {
      return currencyFormatter.format(cents / 100.0);
    }
    
    public function sumExpendituresOverCategories():void {
      for (var c:int = 0 ; c < categories.length ; c++) {
        var category:Category = categories[c];
        /*category.expenditureSum = 0.0;
        category.expenditureCount = 0;*/
        if (category.expenditures) { // we don't know if we have both categories and expenditures yet, so check
          category.expenditureSum = 0.0;
          for (var e:int = 0 ; e < category.expenditures.length; e++)  {
            category.expenditureSum += category.expenditures[e].amount;
          }
          category.expenditureCount = category.expenditures.length;
        }
        trace(category.name + " expenditures = " + category.expenditureSum);
      }
    }    
    
    private function onCacheUpdate(event:CacheUpdateEvent):void {
      //trace("SpendrModel#onCacheUpdate: " + event.fqn);
      if (event.isFor(User)) {
        trace("setting current User to " + Rx.models.cached(User)[0].email)
        currentUser = Rx.models.cached(User)[0];
        categories = currentUser.categories;
        expenditures = currentUser.expenditures;        
      } else if (event.isFor(Category)) {
        trace("SpendrModel#onCachUpdate for Categories");
        categories = Rx.models.cached(Category);
      } else if (event.isFor(Expenditure)) {
        trace("SpendrModel#onCachUpdate for Expenditures");
        expenditures = Rx.models.cached(Expenditure);
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