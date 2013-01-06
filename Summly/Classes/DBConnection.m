//
//  DBConnection.m
//  SyjRedess
//
//  Created by rex on 12-10-31.
//
//

#import "DBConnection.h"

static sqlite3 * theDatabase = nil;


@implementation DBConnection

+ (sqlite3*)openDatabase:(NSString*)dbFilename
{
    sqlite3 * instance;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:dbFilename];
                
    if (sqlite3_open([path UTF8String], &instance) != SQLITE_OK) {
        sqlite3_close(instance);
        NSLog(@"Failed to open database. (%s)", sqlite3_errmsg(instance));
        return nil;
    }
    
    return instance;
}

+(sqlite3 *)getSharedDatabase{
    
    if (theDatabase ==nil) {
        theDatabase = [self openDatabase:MAIN_DATABASE_NAME];
        if (theDatabase==nil) {
             [DBConnection createEditableCopyOfDatabaseIfNeeded:true];
            NSLog(@"Local cache database has been corrupted. Re-created new database.");
        }
        
    }
      return theDatabase;
}

//delete caches

const char *delete_pins_chache_sql =
"BEGIN;"
"DELETE FROM pin;"
"COMMIT"
"VACUUM;";

+(void)deletePinsCache{
    char *errmsg;
    [self getSharedDatabase];
    if (sqlite3_exec(theDatabase, delete_pins_chache_sql, NULL, NULL, &errmsg)!=SQLITE_OK) {
        NSLog(@"%s",errmsg);
    }
    
}

const char *optimize_sql = "VACUUM; ANALYZE";
+ (void)closeDatabase
{
    char *errmsg;
    if (theDatabase) {
		        
      	int launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"launchCount"];
        NSLog(@"launchCount %d", launchCount);
        if (launchCount-- <= 0) {
            NSLog(@"Optimize database...");
            if (sqlite3_exec(theDatabase, optimize_sql, NULL, NULL, &errmsg) != SQLITE_OK) {
                NSLog(@"Error: failed to cleanup chache (%s)", errmsg);
            }
            launchCount = 50;
        }
        [[NSUserDefaults standardUserDefaults] setInteger:launchCount forKey:@"launchCount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sqlite3_close(theDatabase);
    }
}

+ (void)migrate:(NSString*)dbname to:(NSString*)newdbname queries:(NSString*)query_file
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *oldDBPath = [documentsDirectory stringByAppendingPathComponent:dbname];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:newdbname];
    
    
    BOOL success = [fileManager fileExistsAtPath:oldDBPath];
       
    if (success) {
        sqlite3 *oldDB = [DBConnection openDatabase:dbname];
        char *errmsg;
        NSString *migrateSQL = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:query_file];
        NSData *sqldata = [fileManager contentsAtPath:migrateSQL];
        NSString *sql = [[NSString alloc] initWithData:sqldata encoding:NSUTF8StringEncoding] ;
        if (sqlite3_exec(oldDB, [sql UTF8String], NULL, NULL, &errmsg) == SQLITE_OK) {
            // succeeded to update.
            [fileManager moveItemAtPath:oldDBPath toPath:writableDBPath error:&error];
            NSLog(@"Updated database (%@)", query_file);
            return;
        }
         NSLog(@"Failed to update database (Reason: %s). Discard %@ data...", errmsg, dbname);
        [fileManager removeItemAtPath:oldDBPath error:&error];
    }
}

// Creates a writable copy of the bundled default database in the application Documents directory.
+(void)createEditableCopyOfDatabaseIfNeeded:(BOOL)force{
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:MAIN_DATABASE_NAME];

    
    
    [DBConnection migrate:@"dbsyj1.0.sql" to:@"dbsyj1.1.sql" queries:@"update_v1.0_to_v1.1.sql"];
    [DBConnection migrate:@"dbsyj1.1.sql" to:@"dbsyj1.2.sql" queries:@"update_v1.1_to_v1.2.sql"];
    [DBConnection migrate:@"dbsyj1.2.sql" to:@"dbsyj1.3.sql" queries:@"update_v1.2_to_v1.3.sql"];
    
    
    if (force) {
        [fileManager removeItemAtPath:writableDBPath error:&error];
    }
    
    // No exists any database file. Create new one.
    //
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:MAIN_DATABASE_NAME];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        
    if (!success) {
        
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

+(void)beginTransaction{
    char *errmsg;
    sqlite3_exec(theDatabase, "BEGIN", NULL, NULL, &errmsg);
}

+ (void)commitTransaction
{
    char *errmsg;
    sqlite3_exec(theDatabase, "COMMIT", NULL, NULL, &errmsg);
}
+(Statement *)statementWithQuery:(const char *)sql{
    Statement* stmt = [Statement statementWithDB:theDatabase query:sql];
    return stmt;
}

@end
