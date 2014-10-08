//
//  BIDDFWorkout.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDDFWorkout : NSObject

@property (strong, nonatomic) NSMutableDictionary *details;
@property (strong, nonatomic) NSArray *workouts;
@property (strong, nonatomic) NSDictionary *dfExercises;
@property (strong, nonatomic) NSDictionary *detailsGenerated;

-(NSString*)generate:(NSString*)location :(NSString*)targetArea :(NSString*)diffLvl;

-(NSMutableArray*)workoutArray;

@end
