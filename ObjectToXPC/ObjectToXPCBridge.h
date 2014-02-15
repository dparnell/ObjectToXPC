//
//  ObjectToXPCBridge.h
//  ObjectToXPC
//
//  Created by Daniel Parnell on 15/02/2014.
//  Copyright (c) 2014 Aron Cedercrantz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectToXPCBridge : NSObject

+ (xpc_object_t) XPCFromNSObject:(id)object;
+ (id) NSObjectFromXPC:(xpc_object_t)xpc;

@end
