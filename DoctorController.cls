public with sharing class DoctorController 
{
    // Doctors field displaying doctors to show on the page
    public List<Doctor__c> doctors { get ; set ; }
    // Lists of SelectOptions holding picklist values for our inputs
    public List<SelectOption> specializations { get ; set ; }
    public List<SelectOption> languages { get ; set ; }
    public List<SelectOption> genders { get ; set ; }
    // SelectOptions fields holding the actual option selected for each picklist
    public String drSpec { get ; set ; }
    public String drLang { get ; set ; }
    public String drGend { get ; set ; }
    
    public DoctorController()
    {	unfilter();
     	specializations = specOptions();
        System.debug('Specializations are :' + specializations);
		languages = langOptions();
        System.debug('Languages are :' + languages);
		genders = genderOptions();
        System.debug('Genders are :' + genders);
        drSpec = specializations[0].getValue();
        drLang = languages[0].getValue();
        drGend = genders[0].getValue();
    }
    
    public void filter()
    {	doctors = 	[	SELECT 	id, Name, Specialization__c, 
                		Language__c, Gender__c 
                		FROM Doctor__c 
                		WHERE Specialization__c =: drSpec
                		AND Language__c =: drLang
                		AND Gender__c =: drGend
    				];	// display all drs who meet selectlist requirements
    }
    
    public void unfilter()
    {	doctors = 	[	SELECT 	id, Name, Specialization__c, 
                        		Language__c, Gender__c 
                    	FROM Doctor__c
                 	]; 	// display all doctors in the db        
    }
    
    public void genDoctors () { DoctorFactory.generate(20); }
    public void cleanDoctors () { DoctorFactory.Cleanup(); } 
    
    public List<SelectOption> genderOptions()
    {   List<selectOption> genders = new List<selectOption>{};
        for ( PicklistEntry gend : 	Doctor__c.Gender__c.getDescribe().getPicklistValues() )
    		genders.add( new SelectOption( gend.getLabel(), gend.getValue() ) );
        return genders; 
    }
    public List<SelectOption> langOptions()
    {   List<selectOption> languages = new List<selectOption>{};
        for ( PicklistEntry lang : 	Doctor__c.Language__c.getDescribe().getPicklistValues() )
    		languages.add( new SelectOption( lang.getLabel(), lang.getValue() ) );
        return languages; 
    }
    public List<SelectOption> specOptions()
    {   List<selectOption> specializations = new List<selectOption>{};
        for ( PicklistEntry spec : 	Doctor__c.Specialization__c.getDescribe().getPicklistValues() )
    		specializations.add( new SelectOption( spec.getLabel(), spec.getValue() ) );
        return specializations; 
    }
}