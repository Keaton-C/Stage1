public class RegistrationController {
   
    
    public String First_Name{get;set;}
    public String Last_Name{get;set;}
	public String Username{get;set;}
   	public String Password{get;set;}
    public List <SelectOption> Gender {get;set;}
    public String myGender {get;set;}
	public Integer Age{get;set;}
    public String Phone{get;set;}
    public String Email{get;set;}
    public String Address{get;set;}
    public String City{get;set;}
    public Integer Zipcode{get;set;}
    public RegistrationController(){
    Gender=getGender();
    }
     
    public List <SelectOption> getGender(){
     List <SelectOption> option=new List<SelectOption>();  
       for (Picklistentry g : User.Gender__c.getDescribe().getPicklistValues())
        {
            option.add(new SelectOption(g.getLabel(),g.getValue()));
        }
        return option;
    
    }
    User UserData=new User(First_Name__c=First_Name,Username=this.Username,Password__c=Password,Phone=this.Phone);
    public void InsertUserData(){
    insert UserData;
    }
       
        
    
    }// end class