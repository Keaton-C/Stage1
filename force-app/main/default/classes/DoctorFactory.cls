// Generates a bunch of contacts of type Doctor for testing
// Doesn't enable them as partners or anything, just connects them to Southern Heart
public class DoctorFactory 
{	// All doctors will be contacts of the account SouthernHeart
    static Account SouthernHeart = 	[ 	SELECT Id 
                             			FROM Account 
                             			WHERE Name = 'Southern Heart' 
                            		] [0];
    // PicklistEntry lists have namespaces for easy reference
    static List<PicklistEntry> specialties = Contact.Specialty__c.getDescribe().getPicklistValues();
    static List<PicklistEntry> languages = Contact.Language__c.getDescribe().getPicklistValues();
    static List<PicklistEntry> genders = Contact.Gender__c.getDescribe().getPicklistValues();
    
	public static List<Contact> generate ( Integer drCount )
    {
        List<Contact> newDocs = new List<Contact>();
        for ( Integer i = 0 ; i < drCount ; i++ )
        {	Contact dr = new Contact( 	FirstName = 'Roy', 
                                     	LastName = 'Disney the ' + i + 'st'
                                    );
       		dr.AccountID = SouthernHeart.Id;
           	dr.Type__c = 'Doctor';
            dr.Specialty__c = specialties[ Integer.valueOf( Math.random() * specialties.size() ) ].getValue();
			dr.Language__c = languages[ Integer.valueOf( Math.random() * languages.size() ) ].getValue();
            dr.Gender__c = genders[ Integer.valueOf( Math.random() * genders.size() ) ].getValue();
            newDocs.add(dr);
        }
        insert newDocs;
        return newDocs;
    }
    
    public static void Cleanup()
    {	delete [	SELECT id 
                	FROM Contact 
                	WHERE FirstName = 'Roy' 
                	AND LastName LIKE 'Disney the %th'
               ];
        
    }
}