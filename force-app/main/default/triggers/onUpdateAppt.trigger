trigger onUpdateAppt on Appointment__c (before update, after update) 
{/*
    list<Appointment__c> appt= new list<Appointment__c>();
    if (trigger.isBefore && trigger.isUpdate){
            for(Appointment__c ap:trigger.old){
                if(ap.status__c=='Rejected'){
                    ap.addError('You are not allow to bring change to the cancelled appointment!');
                }
            }
     }
 if (trigger.isAfter && trigger.isUpdate){
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    for(Appointment__c em :trigger.new){
       if(em.schstatus__c=='Cancelled'){
    			if(em.patid__r.Email != null && em.patid__r.Name != null) {
       
        //Create a new Email
      			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
      //*************Set list of people who should get the email
      			List<String> sendTo = new List<String>();
      			sendTo.add(em.Patid__r.Email);
      			mail.setToAddresses(sendTo);
       			mail.setTargetObjectId(em.PatId__r.Id);
        
         		// ******************  Set who the email is sent from
       mail.setReplyTo('hazratzai.sabir@gmail.com');
      mail.setSenderDisplayName('Sabir H');
    
    
      // ******  Set email contents - you can use variables!
      mail.setSubject('Cancel Appointment');
      String body = 'Dear ' + em.Patid__r.FirstName + ', ';
      body += 'Email Body';
      
      mail.setHtmlBody(body);
    
      //********** Add  email to the master list
      mails.add(mail);
    }
  }
  //******* Send all emails in the master list
  Messaging.sendEmail(mails);
}


     }
*/}