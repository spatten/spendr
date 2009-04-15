package spendr.models {
  
  import org.restfulx.models.RxModel;
  
  [Resource(name="expenditures")]
  [Bindable]
  public class Expenditure extends RxModel {
    public static const LABEL:String = "name";

    public var name:String = "";

    public var description:String = "";

    public var amount:int = 0;

    public var purchaseDate:Date = new Date;

    [BelongsTo]
    public var category:Category;

    [BelongsTo]
    public var user:User;

    public function Expenditure() {
      super(LABEL);
    }
  }
}
