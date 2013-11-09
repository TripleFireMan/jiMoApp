//
//  ASIBaseDataRequest.h
//  hupan
//
//  Created by lian jie on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITTRequestResult.h"
#import "ASIFormDataRequest.h"
#import "ITTBaseDataRequest.h"

/**
 * NOTE:BaseDataRequest will handle it`s own retain/release lifecycle management, no need to release it manually
 */
@interface ITTASIBaseDataRequest : ITTBaseDataRequest
{
}

- (void)requestDidReceiveReponseHeaders:(ASIFormDataRequest*)request;

@end
