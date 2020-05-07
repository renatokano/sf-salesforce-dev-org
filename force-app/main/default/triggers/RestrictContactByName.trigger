trigger RestrictContactByName on Contact (before insert, before update) {
  // check contacts prior to insert / update for invalid data
  for (Contact c : Trigger.new) {
    // 'INVALIDNAME' is an invalid value
    if(c.LastName == 'INVALIDNAME'){
      c.addError('Test Last Name "'+ c.LastName +'" is not allowed for DML');
    }
  }
}