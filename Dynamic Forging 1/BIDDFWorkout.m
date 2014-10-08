//
//  BIDDFWorkout.m
//  Dynamic Forging 1
//
//  Created by David Sanders on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIDDFWorkout.h"

#include "stdlib.h"

@implementation BIDDFWorkout

@synthesize details;
@synthesize workouts;
@synthesize dfExercises;
@synthesize detailsGenerated;

-(NSString*)generate:(NSString*)location :(NSString*)targetArea :(NSString*)diffLvl{
    //open the default workouts plist file and place into NSURL
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"DFexercises" withExtension:@"plist"];
    //put the contents of the plist into a NSDictionary, and then into dfExercise instance variable
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    self.dfExercises = dictionary;
    //take all the keys in the dictionary and make an array out of those key names
    self.workouts = [self.dfExercises allKeys];
    
    // Get the workout settings for home and gym from the internal plist file
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"WorkoutSettings.plist"];
    NSMutableDictionary *savedWorkoutSettingsDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    
    ///////////generating the number of workouts based on the difficulty level///////////
    ///////////generating the difficulty level set based of the diff lvl and number of workouts//////////
    NSInteger numWorkouts = 0;
    NSInteger diffLvlSet = 0;
    NSString *dls = [[NSString alloc]init];
    NSInteger diffLvlNum = [diffLvl intValue];
    NSMutableArray *chosenEx = [[NSMutableArray alloc] init];   //final list of workouts
    NSMutableArray *cardioEx = [[NSMutableArray alloc] init];   //just cardio workouts
    NSMutableArray *filteredEx = [[NSMutableArray alloc] init]; //exercises after the filter
    switch (diffLvlNum) {
        case 1:
            numWorkouts = arc4random()%2 + 2;
            if (numWorkouts == 2 || numWorkouts == 3) {
                diffLvlSet = 1;
                dls = @"dls1";
            }
            break;
        case 2:
            numWorkouts = arc4random()%3 + 2;
            if (numWorkouts == 2 || numWorkouts == 3) {
                diffLvlSet = 2;
                dls = @"dls2";
            }else {
                diffLvlSet = 1;
                dls = @"dls1";
            }
            break;
        case 3:
            numWorkouts = arc4random()%4 + 2;
            if (numWorkouts == 2 || numWorkouts == 3) {
                diffLvlSet = 3;
                dls = @"dls3";
            }else if (numWorkouts == 4) {
                diffLvlSet = 2;
                dls = @"dls2";
            }else {
                diffLvlSet = 1;
                dls = @"dls1";
            }
            break;
        case 4:
            numWorkouts = arc4random()%5 + 2;
            if (numWorkouts == 2 || numWorkouts == 3) {
                diffLvlSet = 4;
                dls = @"dls4";
            }else if (numWorkouts == 4) {
                diffLvlSet = 3;
                dls = @"dls3";
            }else if (numWorkouts == 5){
                diffLvlSet = 2;
                dls = @"dls2";
            }else {
                diffLvlSet = 1;
                dls = @"dls1";
            }
            break;
            
        default:
            break;
    }
    
    /////////filters the workout for body type/////////////
    if ([targetArea isEqualToString:@"upper"] || [targetArea isEqualToString:@"lower"])
    {
        for (NSString *ex in self.workouts)
        {
            self.details = [dfExercises valueForKey:ex];
            if ([[self.details valueForKey:@"body"] isEqualToString:targetArea] || [[self.details valueForKey:@"body"] isEqualToString:@"total"] || [[self.details valueForKey:@"body"] isEqualToString:@"core"])
            {
                [filteredEx addObject:ex];
            }
        }
    }
    else
    {
        [filteredEx addObjectsFromArray:self.workouts];
    }
    
    /////////filters the workout for location/////////////
    /*
    if ([location isEqualToString:@"home"])
     {
        NSMutableArray *tempEx = [[NSMutableArray alloc]init];
        for (NSString *ex in filteredEx)
        {
            self.details = [dfExercises valueForKey:ex];
            if ([[self.details valueForKey:@"location"] isEqualToString:@"location"])
            {
                [tempEx addObject:ex];
            }
        }
        [filteredEx removeAllObjects];
        [filteredEx addObjectsFromArray:tempEx];
    }
     */
    if ([location isEqualToString:@"home"])
    {
        NSMutableArray *tempEx = [[NSMutableArray alloc]init];
        for (NSString *ex in filteredEx)
        {
            NSDictionary *settings = [savedWorkoutSettingsDictionary valueForKey:ex];
            if ([[settings valueForKey:@"home"] isEqualToString:@"on"])
            {
                [tempEx addObject:ex];
            }
        }
        [filteredEx removeAllObjects];
        [filteredEx addObjectsFromArray:tempEx];
    }
    
    if ([location isEqualToString:@"gym"])
    {
        NSMutableArray *tempEx = [[NSMutableArray alloc]init];
        for (NSString *ex in filteredEx)
        {
            NSDictionary *settings = [savedWorkoutSettingsDictionary valueForKey:ex];
            if ([[settings valueForKey:@"gym"] isEqualToString:@"on"])
            {
                [tempEx addObject:ex];
            }
        }
        [filteredEx removeAllObjects];
        [filteredEx addObjectsFromArray:tempEx];
    }
    
    /////////buiiding array of cardio//////////
    if ([cardioEx count] != 0) {
        [cardioEx removeAllObjects];
    }
    for (NSString *ex in workouts){
        self.details = [dfExercises valueForKey:ex];
        if ([[self.details valueForKey:@"type"] isEqualToString:@"cardio" ]) {
            [cardioEx addObject:ex];
        }
    }
    
    
    if ([cardioEx count] >= 1 && [filteredEx count] >= 6)   //checks to make sure that there are enough workouts. Cardio has to be at least 1, and regular exercises at least 6
    {
        /////////choosing the workouts in the main list////////////
        NSString *cardio = [[NSString alloc]init];
        
        NSInteger buildRun = 0; //for the while loop. counts the iterations for building the workout
        BOOL chooseDone = FALSE;    //decides if the build is complete based on cardio and number of workouts
        NSInteger percentOfCardio = 50; //sets percentage chance if cardio is manditory
        NSInteger randCardio = arc4random()%100 + 1;    //chooses randomly if cardio is manditory
        
        while (chooseDone == FALSE) {   //if cardio randomizer fails, it returns here to rechoose workouts
            [chosenEx removeAllObjects];
            
            while ([chosenEx count] < numWorkouts) {    //builds the workout after location and body type filters have been done
                NSInteger num = arc4random()%[filteredEx count];
                
                if (![chosenEx containsObject:[filteredEx objectAtIndex:num]] ) {    //builds the correct # of exercises
                    [chosenEx addObject:[filteredEx objectAtIndex:num]];
                    buildRun++;
                }
            }
            if (randCardio > percentOfCardio){  //checks to see if cardio passes
                NSMutableArray *chosenExCopy = [[NSMutableArray alloc] initWithArray:chosenEx copyItems:YES];
                
                for (NSString *ex in chosenEx){
                    self.details = [dfExercises valueForKey:ex];
                    
                    if ([[self.details valueForKey:@"type"] isEqualToString:@"cardio" ]) {
                        chooseDone = TRUE;
                        cardio = @"yes";
                        break;
                    }else {
                        cardio = @"made";
                        
                    }   //end of if block for checking to se if there was a cardio in the array
                }   //end of for loop checking all of the exercises
                
                if ([cardio isEqualToString:@"made"]) { //if the exercises don's contain cardio, insert one
                    NSInteger insertIndex = arc4random()%[cardioEx count];
                    NSInteger atIndexInt = arc4random()%[chosenExCopy count];
                    [chosenExCopy replaceObjectAtIndex:atIndexInt withObject:[cardioEx objectAtIndex:insertIndex]];
                    chooseDone = TRUE;
                }
                chosenEx = [[NSMutableArray alloc] initWithArray:chosenExCopy copyItems:YES];
            }else {
                chooseDone = TRUE;
                cardio = @"cardio = no";
            }
        }
        ////////choosing the number of Rounds//////////
        NSInteger rounds = arc4random()%6 + 1;
        
        //NSMutableString *display = [[NSMutableString alloc] initWithFormat:@"numWorkouts = %i \n diffLvlSet = %i \n cardio = %@ \n rounds = %i \n location = %@ \n", numWorkouts, diffLvlSet, cardio, rounds, location];
        NSMutableString *display = [[NSMutableString alloc]init];
        NSMutableDictionary *detailsGen = [[NSMutableDictionary alloc]init];
        NSInteger numChosenEx = [chosenEx count];
        for (NSInteger x = 0; x<numChosenEx;x++){
            self.details = [dfExercises valueForKey:[chosenEx objectAtIndex:x]];
            NSInteger totalReps = [[self.details valueForKey:dls] intValue];
            [display appendFormat:@"%i    %@\n",totalReps/rounds,[chosenEx objectAtIndex:x]];
            NSString *line = [[NSString alloc] initWithFormat:@"%i    %@",totalReps/rounds,[chosenEx objectAtIndex:x]];
            NSString *key = [[NSString alloc]initWithFormat:@"%d",x+1];
            [detailsGen setObject:line forKey:key];
        }
        NSString *roundLine = [[NSString alloc] initWithFormat:@"%i Rounds For Time", rounds];
        [detailsGen setObject:roundLine forKey:@"Notes"];
        [detailsGen setObject:@"My DFG Workouts" forKey:@"Type"];
        [detailsGen setObject:@"normal" forKey:@"Timer"];
        self.detailsGenerated = detailsGen;
        [display appendFormat:@"\n %@",roundLine];
        return display;
    }
    else
    {
        return @"";
    }
}



//just a test method
-(NSDictionary*)workoutArray{
    return self.detailsGenerated;
}


@end
