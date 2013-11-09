//
//  ITTFileModel.h
//  iTotemFramework
//
//  Created by Sword Zhou on 8/8/13.
//  Copyright (c) 2013 iTotemStudio. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface ITTFileModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *mimeType;
@property (nonatomic, strong) NSData *data;

@end
