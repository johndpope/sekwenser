//
//  PSPattern.m
//  sekwenser
//
//  Created by フィヨ on 10/10/09.
//  Copyright 2010 Fjölnir Ásgeirsson. All rights reserved.
//

#import "PSPattern.h"
#import "PSStep.h"

@implementation PSPattern
@synthesize steps, note, muted;
+ (PSPattern *)emptyPatternWithNote:(uint8_t)inNote numberOfSteps:(NSUInteger)numberOfSteps
{
	PSPattern *ret = [[self alloc] init];
	ret.note = inNote;
	ret.steps   = [NSMutableArray array];
	
	for(int i = 0; i < numberOfSteps; ++i)
	{
		[ret.steps addObject:[PSStep stepWithVelocity:127]];
	}
	return [ret autorelease];
}

- (id)copyWithZone:(NSZone *)zone
{
	PSPattern *copy = [[PSPattern alloc] init];
	copy.steps = [[[NSMutableArray alloc] initWithArray:self.steps copyItems:YES] autorelease];
	copy.muted = self.muted;
	copy.note = self.note;
	return copy;
}
- (id)initWithCoder:(NSCoder *)coder
{
	if(!(self = [super init]))
		return nil;
	
	self.steps = [coder decodeObjectForKey:@"steps"];
	self.note = [coder decodeIntForKey:@"note"];
	self.muted = [coder decodeBoolForKey:@"muted"];
	
	return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.steps forKey:@"steps"];
	[coder encodeInt:self.note forKey:@"note"];
	[coder encodeBool:self.muted forKey:@"muted"];
}
@end