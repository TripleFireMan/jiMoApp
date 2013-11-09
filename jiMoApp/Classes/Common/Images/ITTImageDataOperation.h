//
//  ITTImageDataOperation.h
//  AiQiChe
//
//  Created by lian jie on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ITTImageDataOperationDelegate;

@interface ITTImageDataOperation : NSOperation

@property (nonatomic, weak) id<ITTImageDataOperationDelegate> delegate;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) CGSize targetSize;

- (id)initWithURL:(NSString *)url delegate:(id<ITTImageDataOperationDelegate>)delegate;

@end

@protocol ITTImageDataOperationDelegate <NSObject>

-(void)imageDataOperation:(ITTImageDataOperation*)operation loadedWithUrl:(NSString*)url withImage:(UIImage*)image;

@end