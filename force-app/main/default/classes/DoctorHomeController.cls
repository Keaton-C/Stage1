public class DoctorHomeController 
{   public String currentId { get ; set ; }
    public List<AppointmentContacts__c> patients { get ; set ; }
    private string status='';
    User currUser;
    Contact currContact;

    public DoctorHomeController () 
    {	currUser = 	[	Select Id, ContactId 
                     	from User 
                     	where Id = :UserInfo.getUserId() 
                    ];
        //currContact = [ SELECT Id FROM Contact WHERE Id = :currUser.ContactID ];
        // For the purpose of testing, set current contact to Roy Disney
        currContact = [ SELECT Id FROM Contact WHERE Name = 'Roy Disney the 0st'];
		getAppointment();
    }
    
    public void allStatus(){
       status='';
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
    public void accept(){
    	System.debug('Check out this cool ID: ' + currentID);
        updateStatus('Confirmed');
        getAppointment();
    }
    public void reject(){
		updateStatus('Rejected');
        status='';
        getAppointment();
    }
    
 	// Call this method to update the page and refetch results
  	private  void getAppointment()
    {	// make a list of appointment junctions involving current user
        List<AppointmentContacts__c> doctorApps = 	
        [ 	SELECT Appointment__r.id
          	FROM AppointmentContacts__c 
           	WHERE Contact__r.Id = :currContact.Id
        ];
        // make a list of IDs for those junctions
        List<ID> groundhog = new List<ID>();
        for ( AppointmentContacts__c app : doctorApps ) 
        	groundhog.add(app.Appointment__r.id);
        // make a list of apppointment junctions on the other side of appointment
        patients = 
        [	SELECT 	Id, Appointment__r.Id, Appointment__r.Start_Time__c, Appointment__r.Status__c,
           			Contact__r.Id, Contact__r.Name, Contact__r.Phone, Contact__r.Email
           	FROM AppointmentContacts__c
          	WHERE Appointment__r.Id IN :groundhog	// same appointment the doctor is in
         	AND Contact__r.Id != :currContact.Id	// contact to be listed is not the doctor
         	AND Appointment__r.Status__c LIKE :status+'%'
        ];
    }
        
  public void updateStatus(String newStatus)
  {   
      for ( AppointmentContacts__c curr: 
           [	SELECT id, Appointment__r.id, Appointment__r.Status__c
                FROM AppointmentContacts__c
                WHERE id=:currentId
           ]
          )
      {	  System.debug('You have selected appointment: ' + curr.id);
          curr.Appointment__r.status__c = newStatus;
          update curr.Appointment__r;
      }
               
                                  
    }
    public pagereference logout()
    {
       //perform Business logic here
        PageReference pageRef = new PageReference('/default/secur/logout.jsp');
        pageRef.setRedirect(true);
        return pageRef;
    }
   
    
}