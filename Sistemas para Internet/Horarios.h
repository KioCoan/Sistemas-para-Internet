//
//  Horarios.h
//  Sistemas para Internet
//
//  Created by Kio Coan on 17/09/14.
//  Copyright (c) 2014 Kio Coan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Horarios : NSManagedObject

@property (nonatomic, retain) NSNumber * semestre;
@property (nonatomic, retain) NSNumber * diaS;
@property (nonatomic, retain) NSString * nomeProf;
@property (nonatomic, retain) NSString * nomeDisc;
@property (nonatomic, retain) NSString * localizacao;
@property (nonatomic, retain) NSString * cods;
@property (nonatomic, retain) NSNumber * codH;

@end
