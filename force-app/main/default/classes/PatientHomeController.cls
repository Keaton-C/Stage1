public class PatientHomeController 
{	private string status='';
    String userName = UserInfo.getUserId();
    User currUser;
    Contact currContact;
 	Public List<AppointmentContacts__c> appts { get ; set ; }
 
 	public PatientHomeController () 
    {	currUser = 	[	Select Id, ContactId 
                     	from User 
                     	where Id = :UserInfo.getUserId() 
                    ];
        //currContact = [ SELECT Id FROM Contact WHERE Id = :currUser.ContactID ];
        // For the purpose of testing, set current contact to Sacky Burger
        currContact = [ SELECT Id FROM Contact WHERE Name = 'Sacky Burger'];
		getAppointment();
    }
 
 	public void allStatus()
    {	status='';
       	getAppointment();
    }
    
    public void Pending()
    {  	status='Pending';
       	getAppointment();
    }
    public void Completed()
    {  	status='Completed';
  		getAppointment();
    }
    public void Rejected()
    {   status='Rejected';
        getAppointment();
    }
    public void Confirmed()
    { 	status='Confirmed';
      	getAppointment();
    }
    
    public void getAppointment(){
    {	// make a list of appointment junctions involving this patient
        List<AppointmentContacts__c> patientApps = 	
        [ 	SELECT Appointment__r.id
          	FROM AppointmentContacts__c 
           	WHERE Contact__r.Id = :currContact.Id
        ];
        // make a list of IDs for those junctions
        List<ID> groundhog = new List<ID>();
        for ( AppointmentContacts__c app : patientApps ) 
        	groundhog.add(app.Appointment__r.id);
        // make a list of appointment junctions on the other side of appointment
        appts = 
        [	SELECT 	Id, Appointment__r.Id, Appointment__r.Start_Time__c, Appointment__r.Status__c,
           			Contact__r.Id, Contact__r.Name, Contact__r.Phone, Contact__r.Email,
         			Contact__r.Specialty__c, Contact__r.Language__c, Contact__r.Gender__c
           	FROM AppointmentContacts__c
          	WHERE Appointment__r.Id IN :groundhog	// same appointment the patient is in
         	AND Contact__r.Id != :currContact.Id	// contact to be listed is not the patient
         	AND Appointment__r.Status__c LIKE :status+'%'
        ];
    }
        
    }
        
  
    public pagereference logout(){
       //perform Business logic here
        PageReference pageRef = new PageReference('/default/secur/logout.jsp');
        pageRef.setRedirect(true);
        return pageRef;
    }
    public PageReference docPage() {
        PageReference pr = new PageReference('/apex/DoctorHomePage');
        pr.setRedirect(true);
        return pr;
    }
    
}