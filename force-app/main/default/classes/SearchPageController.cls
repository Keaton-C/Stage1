public class SearchPageController {
    
    static public string specialization{get;set;}
    static public string language{get;set;}
    static public string gender{get;set;}
    
    //Set User Input from text fields using IDs
    public static void setSpecialization(String s){
        specialization=s;
    }
    
    public static void setLanguage(String s){
        language=s;
    }
    
    public static void setGender(String s){
        gender=s;
    }
    
    //Retrieve User Input to use in Org
    public static String getSpecialization(){
        return specialization;
    }
    
    public static String getLanguage(){
        return language;
    }
    
    public static String getGender(){
        return gender;
    }
}