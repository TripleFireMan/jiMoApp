//
//  AddressBookUtils.h
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
@interface AddressBookUtils : NSObject {
}
+ (BOOL)isCellPhoneNum:(NSString*)num;
+ (NSMutableArray *)getAllContacts;
// get label of phone number (e.g. Mobile, Home, etc)
+ (NSString *)getPhoneLabel:(ABMultiValueRef)phones index:(int)index;
// get full name of contact
+ (NSString *)getFullName:(ABAddressBookRef)addressBook personId:(int)personId;
+ (NSString *)getFullName:(ABRecordRef)person;
// get all phone numbers of one contact
+ (NSArray *)getPhones:(ABRecordRef)person;

+ (NSString*)getFirstCellPhoneNum:(ABRecordRef)person;
// get all emails of one contact
+ (NSArray *)getEmails:(ABRecordRef)person;
+ (NSString *)getFirstEmail:(ABRecordRef)person;
// get image of contact
+ (UIImage*)getImageByPerson:(ABRecordRef)person;
+ (BOOL)hasImageByPerson:(ABRecordRef)person;
+ (UIImage*)getSmallImage:(ABRecordRef)person size:(CGSize)size;
+ (NSString*)getShortName:(ABRecordRef)person;
+ (NSDate*)copyModificationDate:(ABRecordRef)person;
// set address into contact
+ (BOOL)addAddress:(ABRecordRef)person street:(NSString*)street;
// set phones into contact
+ (BOOL)addPhone:(ABRecordRef)person phone:(NSString*)phone;
// set image into contact
+ (BOOL)addImage:(ABRecordRef)person image:(UIImage*)image;
+ (NSArray *)getEmailsWithAddressBook:(ABRecordID)personId addressBook:(ABAddressBookRef)addressBook;
+ (NSArray *)getPhonesWithAddressBook:(ABRecordID)personId addressBook:(ABAddressBookRef)addressBook;
+ (BOOL)hasPhones:(ABRecordRef)person;
+ (BOOL)hasCellPhones:(ABRecordRef)person;
+ (BOOL)hasEmails:(ABRecordRef)person;
+ (NSString*)getPersonNameByPhone:(NSString*)phone addressBook:(ABAddressBookRef)addressBook;

+ (ABRecordRef)getPersonByPhone:(NSString*)phone addressBook:(ABAddressBookRef)addressBook;
@end


