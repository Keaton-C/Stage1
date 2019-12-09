// Generates a bunch of appointments attached to currently existing contacts
// You have to make an object of this class for it to work, since it uses contacts on construction
// Definitely run the cleanup method ASAP.  It randomly assigns appointments between all drs and patients
// in the db!
public class AppointmentFactory 
{
    static final String dcode = 'DELETE ME LATER';
    static Account SouthernHeart = 	[ 	SELECT Id 
                             			FROM Account 
                             			WHERE Name = 'Southern Heart' 
                            		] [0];
    List<Contact> drs;	// initialized in the constructor to all drs
    List<Contact> pats;	// initialized in the constructor to all patients
    
    public AppointmentFactory()
    {
        drs = [ SELECT Id, FirstName, LastName, Email, Phone, Specialty__c, Language__c, Gender__c
               	FROM Contact
               	WHERE Type__c = 'Doctor'
              ];
        pats = 	[	SELECT Id, FirstName, LastName, Email, Phone
              		FROM Contact
                	WHERE Type__c = 'Patient'
              	];
    }
    
    public List<Appointment__c> generate ( Integer count )
    {   // initialize appts and junctions
        List<Appointment__c> appts = new List<Appointment__c>();
        List<AppointmentContacts__c> appcons = new List<AppointmentContacts__C>();
        for ( Integer i = 0 ; i < count ; i++ )
        {   // add new appointment
            Appointment__c a = new Appointment__c( Name = dcode );
        	a.Start_Time__c = System.today().addDays(7);
         	a.Status__c = 'Pending';
         	appts.add(a);
            insert a;
            // add junctions assigning drs and patients to appts
            AppointmentContacts__c dr = new AppointmentContacts__c( Name = dcode );
            dr.Appointment__c = a.Id;
            dr.Contact__c = drs[ Integer.valueOf( Math.random() * drs.size() ) ].Id;
            AppointmentContacts__c pat = new AppointmentContacts__c( Name = dcode );
            pat.Appointment__c = a.Id;
            pat.Contact__c = pats[ Integer.valueOf( Math.random() * pats.size() ) ].Id;
            appcons.add(dr); appcons.add(pat);
        }
        insert appcons;
        return appts;
    }
    public void cleanup()
    {
        delete 	[	SELECT id FROM Appointment__c WHERE Name = : dcode ];
        delete 	[	SELECT id FROM AppointmentContacts__c WHERE Name = : dcode ];
    }

}