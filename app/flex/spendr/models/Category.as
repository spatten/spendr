package spendr.models {
  import org.restfulx.collections.ModelsCollection;
  
  import org.restfulx.models.RxModel;
  
  [Resource(name="categories")]
  [Bindable]
  public class Category extends RxModel {
    public static const LABEL:String = "name";

    public var name:String = "";
    
    [Ignored]
    public var expenditureSum:Number = 0.0;
    
    [Ignored]
    public var expenditureCount:int = 0;

    [BelongsTo]
    public var user:User;

    [HasMany]
    public var expenditures:ModelsCollection;
    
    public function Category() {
      super(LABEL);
    }
  }
}
