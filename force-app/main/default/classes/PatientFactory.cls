// Generates a bunch of contacts of type Patient for testing
// Doesn't enable them as partners or anything, just connects them to Southern Heart
public class PatientFactory 
{	// All doctors will be contacts of the account SouthernHeart
    static Account SouthernHeart = 	[ 	SELECT Id 
                             			FROM Account 
                             			WHERE Name = 'Southern Heart' 
                            		] [0];
    
	public static List<Contact> generate ( Integer patCount )
    {
        List<Contact> newPats = new List<Contact>();
        for ( Integer i = 0 ; i < patCount ; i++ )
        {	Contact pat = new Contact( 	FirstName = 'Sacky', 
                                     	LastName = 'Burger the ' + i + 'st'
                                    );
       		pat.AccountID = SouthernHeart.Id;
           	pat.Type__c = 'Patient';
            newPats.add(pat);
        }
        insert newPats;
        return newPats;
    }
    
    public static void Cleanup()
    {	delete [	SELECT id 
                	FROM Contact 
                	WHERE FirstName = 'Sacky' 
                	AND LastName LIKE 'Burger the %th'
               ];
        
    }
}