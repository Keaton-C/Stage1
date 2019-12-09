public with sharing class SearchPageController 
{   
    // List of Contacts displaying relevant doctors
    public List<Contact> doctors { get ; set ; }
    
    // Hold value of selected dropdown menu item (in theory)
    public String drSpec { get ; set ; }
    public String drLang { get ; set ; }
    public String drGend { get ; set ; }
    
    // Picklist entries get their own namespace for easy reading
    static final List<PicklistEntry> specialties = Contact.Specialty__c.getDescribe().getPicklistValues();
    static final List<PicklistEntry> languages = Contact.Language__c.getDescribe().getPicklistValues();
    static final List<PicklistEntry> genders = Contact.Gender__c.getDescribe().getPicklistValues();
    
    // List of all dropdown menu options
    public List<SelectOption> languageOptions { get ; set ; }
	public List<SelectOption> genderOptions { get ; set ; }
    public List<SelectOption> specialtyOptions { get ; set ; }
    
    static List<String> specs;
    // Toggle PageBlock displaying Doctor's information
    public Boolean showDoctorResults{get;set;}
    
    public SearchPageController()
    {   // Initialize our dropdowns as empty lists
        specialtyOptions = new List<SelectOption>();
        languageOptions = new List<SelectOption>();
        genderOptions = new List<SelectOption>();
        // Add special vals to catch all in a category
        specialtyOptions.add( new SelectOption('', 'Any') );
        languageOptions.add( new SelectOption('', 'Any') );
        genderOptions.add( new SelectOption('', 'Any') );
        // Add all values which the real picklists have
        for ( PicklistEntry spec : specialties )
        	specialtyOptions.add( new SelectOption(spec.label, spec.value) );
        for ( PicklistEntry lang : languages )
            languageOptions.add( new SelectOption(lang.label, lang.value) );
        for ( PicklistEntry gend : genders )
            if ( gend.getLabel() != 'None Specified' )
	            genderOptions.add( new SelectOption(gend.label, gend.value) );
        // Initialize the list selections to top entry (Anything)
        drSpec = specialtyOptions[0].getValue();
        System.debug(drSpec);
        drLang = languageOptions[0].getValue();
        drGend = genderOptions[0].getValue();
        
        filter();
    }
    
    public void filter ()
    {	if ( drSpec == null ) drSpec = '';
     	if ( drLang == null ) drLang = '';
     	if ( drGend == null ) drGend = '';
        doctors = [	SELECT id, Name, Specialty__c, Language__c, Gender__c
                  	FROM Contact
					WHERE Type__c = 'Doctor'
                   	AND Specialty__c LIKE : '%' + drSpec + '%'
                   	// AND Language__c = : '%' + drLang + '%' 
                   	AND Gender__c LIKE : drGend + '%'
                  ];
    }
    
    public void SearchDoctor() {
        // Show doctor results using Boolean and getValue Strings
        filter();
    }
}