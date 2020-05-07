public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String lastName) {
        // create an empty contact list
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0; i<numberOfContacts; i++){
            Contact c = new Contact(
                FirstName = 'Test '+i,
                LastName = lastName
            );
            contacts.add(c);
        }
        return contacts;
    }
}
