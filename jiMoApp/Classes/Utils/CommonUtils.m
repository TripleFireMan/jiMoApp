//
//  CommonUtils.m
//  LingQ
//
//  Created by Rainbow on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommonUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CommonUtils

+ (NSString *)convertArrayToString:(NSArray *)array
{
	NSMutableString *string = [NSMutableString stringWithCapacity:0];
	for( NSInteger i=0;i<[array count];i++ ){
		[string appendFormat:@"%@%@",(NSString *)array[i], (i<([array count]-1))?@",":@""];
	}
	return string;
}

+ (NSArray *)convertStringToArray:(NSString *)string
{
	return [string componentsSeparatedByString:@","];
}

+ (long)getDocumentSize:(NSString *)folderName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
	documentsDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat: @"/%@/", folderName]];
    //	NSDictionary *fileAttributes = [fileManager attributesOfFileSystemForPath:documentsDirectory error:nil];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:documentsDirectory error:nil];
    
    long size = 0;
	if(fileAttributes != nil)
	{
		NSNumber *fileSize = fileAttributes[NSFileSize];
        size = [fileSize longValue];
	}
    return size;
}

+ (NSArray *)getLetters
{
	return @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
}

+ (NSArray *)getUpperLetters
{
	return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}

+ (NSString *)getIPAddress
{
	NSString *address = @"Unknown";
	struct ifaddrs *interfaces = NULL;
	struct ifaddrs *temp_addr = NULL;
	int success = 0;
    
	// retrieve the current interfaces - returns 0 on success
	success = getifaddrs(&interfaces);
	if (success == 0){
		// Loop through linked list of interfaces
		temp_addr = interfaces;
		while(temp_addr != NULL){
			if(temp_addr->ifa_addr->sa_family == AF_INET){
				// Check if interface is en0 which is the wifi connection on the iPhone
                //                address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                //                NSLog(@"address: %@", [NSString stringWithUTF8String:temp_addr->ifa_name]);
				if([@(temp_addr->ifa_name) isEqualToString:@"en0"]){
					// Get NSString from C String
					address = @(inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr));
				}
			}
            
			temp_addr = temp_addr->ifa_next;
		}
	}
    
	// Free memory
	freeifaddrs(interfaces);
    
	return address;
    
    //    char iphone_ip[255];
    //    strcpy(iphone_ip,"127.0.0.1"); // if everything fails
    //    NSHost* myhost =[NSHost currentHost];
    //    if (myhost)
    //    {
    //        NSString *ad = [myhost address];
    //        if (ad)
    //            strcpy(iphone_ip,[ad cStringUsingEncoding: NSISOLatin1StringEncoding]);
    //    }
    //    return [NSString stringWithFormat:@"%s",iphone_ip];
}

+ (NSString *)getFreeMemory
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);        
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
        NSLog(@"Failed to fetch vm statistics");
    
    /* Stats in bytes */ 
    natural_t mem_used = (vm_stat.active_count +
                          vm_stat.inactive_count +
                          vm_stat.wire_count) * pagesize;
    natural_t mem_free = vm_stat.free_count * pagesize;
    //  natural_t mem_total = mem_used + mem_free;
    return [NSString stringWithFormat:@"%0.1f MB used/%0.1f MB free", mem_used/1048576.f, mem_free/1048576.f];
    //    NSLog(@"used: %u free: %u total: %u", mem_used, mem_free, mem_total);
}

+ (NSString *)getDiskUsed
{
    NSDictionary *fsAttr = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    float diskSize = [fsAttr[NSFileSystemSize] doubleValue] / 1073741824.f;
    float diskFreeSize = [fsAttr[NSFileSystemFreeSize] doubleValue] / 1073741824.f;
    float diskUsedSize = diskSize - diskFreeSize;
    return [NSString stringWithFormat:@"%0.1f GB of %0.1f GB", diskUsedSize, diskSize];
}

+ (NSString *)getStringValue:(id)value
{
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        if ([@"" isEqualToString:value]) {
            return nil;
        }
        return value;
    }
    else {
        return [value stringValue];
    }
}

+ (BOOL)createDirectorysAtPath:(NSString *)path
{
    @synchronized(self){
        NSFileManager* manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:path]) {
            NSError *error = nil;
            if (![manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
                return NO;
            }
        }
    }
    return YES;
}

+ (NSString*)getDirectoryPathByFilePath:(NSString *)filepath
{
    
    if(!filepath || [filepath length] == 0){
        return @"";
    }
    
    int pathLength = [filepath length];
    int fileLength = [[filepath lastPathComponent] length];
    return [filepath substringToIndex:(pathLength - fileLength - 1)];
}
@end
