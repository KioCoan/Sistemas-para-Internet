//
//  SingletonHorario.h
//  Sistemas para Internet
//
//  Created by Kio Coan on 18/09/14.
//  Copyright (c) 2014 Kio Coan. All rights reserved.
//

@interface SingletonHorario : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
@property NSNumber* semestreSelecionado;

+ (SingletonHorario*)sharedInstance;

@end
