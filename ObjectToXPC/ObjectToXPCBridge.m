//
//  ObjectToXPCBridge.m
//  ObjectToXPC
//
//  Created by Daniel Parnell on 15/02/2014.
//  Copyright (c) 2014 Aron Cedercrantz. All rights reserved.
//

#import "ObjectToXPCBridge.h"
#import "NSArray+CDXPC.h"
#import "NSData+CDXPC.h"
#import "NSDate+CDXPC.h"
#import "NSNumber+CDXPC.h"
#import "NSString+CDXPC.h"
#import "NSDictionary+CDXPC.h"

@implementation ObjectToXPCBridge

+ (xpc_object_t) XPCFromNSObject:(id)object {
    return [object XPCObject];
}

+ (id) NSObjectFromXPC:(xpc_object_t)xpc {
    
    xpc_type_t valueType = xpc_get_type(xpc);
    id object = nil;
    
    if (valueType == XPC_TYPE_ARRAY) {
        object = [[NSArray alloc] initWithXPCObject:xpc];
    }
    else if (valueType == XPC_TYPE_BOOL ||
             valueType == XPC_TYPE_DOUBLE ||
             valueType == XPC_TYPE_INT64 ||
             valueType == XPC_TYPE_UINT64) {
        object = [[NSNumber alloc] initWithXPCObject:xpc];
    }
    else if (valueType == XPC_TYPE_DATA) {
        object = [[NSData alloc] initWithXPCObject:xpc];
    }
    else if (valueType == XPC_TYPE_DATE) {
        object = [[NSDate alloc] initWithXPCObject:xpc];
    }
    else if (valueType == XPC_TYPE_DICTIONARY) {
        object = [[NSDictionary alloc] initWithXPCObject:xpc];
    }
    else if (valueType == XPC_TYPE_NULL) {
        object = [NSNull null];
    }
    else if (valueType == XPC_TYPE_STRING) {
        object = [[NSString alloc] initWithXPCObject:xpc];
    }
    else {
        char *valueDescription = xpc_copy_description(xpc);
        NSString *assertionString = [[NSString alloc] initWithFormat:@"Unsupported XPC object '%s'.", valueDescription];
        free(valueDescription);
#if DEBUG
        NSAssert(NO, assertionString);
#else
        NSLog(@"%@", assertionString);
#endif
    }
    
    if (object == nil) {
        object = [NSNull null];
    }
    
    return object;
}

@end
