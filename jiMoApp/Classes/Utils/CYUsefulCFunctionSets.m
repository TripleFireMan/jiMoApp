//
//  CYUsefulCFunctionSets.m
//  lottery
//
//  Created by CY on 13-11-4.
//
//

#import "CYUsefulCFunctionSets.h"


#pragma mark - animationMethod
CAKeyframeAnimation *randomBallSizeChangeAnimation()
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    [animation setDuration:0.35];
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSNumber numberWithFloat:1]];
    [values addObject:[NSNumber numberWithFloat:1.2]];
    [values addObject:[NSNumber numberWithFloat:0.8]];
    [values addObject:[NSNumber numberWithFloat:1.1]];
    [values addObject:[NSNumber numberWithFloat:0.9]];
    [values addObject:[NSNumber numberWithFloat:1]];
    [animation setValues:values];
    
    return animation;
}


void animation(NSArray *array,UIView *object,NSString *keyPath)
{
    CAKeyframeAnimation*animation = [CAKeyframeAnimation animation];
    CGMutablePathRef aPath = CGPathCreateMutable();
    CGPathMoveToPoint(aPath,nil, 20, 20);
    CGPathAddCurveToPoint(aPath,nil, 160, 30, 220, 220, 240, 420);
    animation.path= aPath;
    animation.autoreverses= YES;
    animation.duration= 2;
    animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.rotationMode= @"auto";
    [object.layer addAnimation:animation forKey:keyPath];
}

NSString *stampTimeConvertToNormalTime(NSString *stampTime)
{
    NSTimeInterval seconds = [stampTime integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *normalString = [formatter stringFromDate:date];
    return normalString;
}

NSArray *lowerLetters()
{
    return @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
}

NSArray *upperLetters()
{
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}
#pragma mark -
#pragma mark uiMethods

float viewHeight(UIView *view)
{
    return view.frame.size.height;
}

float viewWidth(UIView *view)
{
    return view.frame.size.width;
}

float viewTop(UIView *view)
{
    return view.frame.origin.y;
}

float viewBottom(UIView *view)
{
    return view.frame.origin.y + viewHeight(view);
}

float viewLeft(UIView *view)
{
    return view.frame.origin.x;
}

float viewRight(UIView *view)
{
    return view.frame.origin.x + viewWidth(view);
}

void viewRemoveAllSubView(UIView *view)
{
    NSArray *subviews = [view subviews];
    for (UIView *sub in subviews) {
        [sub removeFromSuperview];
    }
}
#pragma mark -
#pragma mark mathMethods

long long factorial(int num)
{
    long long result = 1;
    while (num!=1&&num!=0) {
        result *= num;
        num--;
    }
    return result;
}

long long combination(int num1,int num2)
{
    long long result = num1;
    if (num1==num2) {
        return 1;
    }else if (num1>num2){
        long long fenmu = factorial(num2);
        long flag = num1;
        while ((num1-1)>(flag- num2)) {
            result *=(num1-1);
            num1--;
        }
        result = result/fenmu;
        return result;
    }else{
        NSLog(@"wrong combination param");
        return 0;
    }
    
}


int max(int a, int b)
{
    if (a>b) {
        return a;
    }else
        return b;
}

int min(int a, int b)
{
    if (a<b) {
        return a;
    }else
        return b;
}
NSArray *randomLotteryArray(int from, int to, int count)
{
    NSMutableArray *numberArray = [NSMutableArray array];
    for (int i = from; i <= to; i++) {
        [numberArray addObject:[NSNumber numberWithInteger:i]];
    }
    
    NSArray *sortedArray = [numberArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return arc4random();
    }];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        [resultArray addObject:[sortedArray objectAtIndex:i]];
    }
    
    return resultArray;
}

NSArray *sortArray(NSArray *array,BOOL isAsc)
{
    if (isAsc) {
        NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            if ([obj1 intValue] > [obj2 intValue]){
                return NSOrderedDescending;
            }
            if ([obj1 intValue] < [obj2 intValue]){
                return NSOrderedAscending;
            }
            return NSOrderedSame;
        }];
        return sortedArray;
    }else {
        NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            if ([obj1 intValue] < [obj2 intValue]){
                return NSOrderedDescending;
            }
            if ([obj1 intValue] > [obj2 intValue]){
                return NSOrderedAscending;
            }
            return NSOrderedSame;
        }];
        return sortedArray;
    }
}

float distanceBetweenTwoPoint(CGPoint p1,CGPoint p2)
{
    return sqrtf((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
}

float degressConvertToRadian(float degress)
{
    float radian = 0.0f;
    radian = (degress * M_1_PI) / 180;
    return radian;
}

float radianConvertToDegress(float radian)
{
    float degress = 0.0f;
    degress = (radian * 180) / M_1_PI;
    return degress;
}

#pragma mark -
#pragma mark colorMethods

UIColor *rgbColor(float r,float g,float b)
{
    UIColor *color = [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1];
    return color;
}

UIColor *rgbaColor(float r,float g,float b,float a)
{
    UIColor *color = [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a];
    return color;
}

NSString *md5(NSString *aString)
{
    const char *stringNeed = [aString UTF8String];
    unsigned char results[CC_MD5_DIGEST_LENGTH];
    CC_MD5(stringNeed, strlen(stringNeed), results);
    NSMutableString *hush = [NSMutableString string];
    for (int i = 0; i< 16; i++) {
        [hush appendFormat:@"%02X", results[i]];
    }
    [hush lowercaseString];
    return hush;
}

#pragma mark -
#pragma mark UIDevice relates
NSString *ipAddress()
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
}

NSString *freeMemory()
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

NSString *diskUsed()
{
    NSDictionary *fsAttr = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    float diskSize = [fsAttr[NSFileSystemSize] doubleValue] / 1073741824.f;
    float diskFreeSize = [fsAttr[NSFileSystemFreeSize] doubleValue] / 1073741824.f;
    float diskUsedSize = diskSize - diskFreeSize;
    return [NSString stringWithFormat:@"%0.1f GB of %0.1f GB", diskUsedSize, diskSize];
}


