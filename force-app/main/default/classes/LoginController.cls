public class LoginController 
{
    //this is my second attempt
    public String UserName{get;set;}
    public String Password{get;set;}
    
    public PageReference loginPat ()
    {  	PageReference pr = new PageReference('/apex/PatientHomePage');
        pr.setRedirect(true);
        return pr;
    }
    public PageReference loginDoc ()
    {  	PageReference pr = new PageReference('/apex/DoctorHomePage');
        pr.setRedirect(true);
        return pr;
    }

}