//
//  DataManager.h
//  Unicom_UC
//
//  Created by Andy.NH on 10/10/12.
//
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager *) sharedInstance;

- (void) saveContext;

- (NSURL *) applicationDocumentsDirectory;


@end
