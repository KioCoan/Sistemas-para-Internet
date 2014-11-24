//
//  Notificacoes.h
//  Sistemas para Internet
//
//  Created by Kio Coan on 17/09/14.
//  Copyright (c) 2014 Kio Coan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notificacoes : NSManagedObject

@property (nonatomic, retain) NSNumber* codN;
@property (nonatomic, retain) NSDate* data;
@property (nonatomic, retain) NSString* texto;
@property (nonatomic, retain) NSString* titulo;

@end
