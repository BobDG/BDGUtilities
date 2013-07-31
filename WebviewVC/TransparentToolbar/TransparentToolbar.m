//
//  TransparentToolbar.m
//  Gemist.fm
//
//  Created by Bob de Graaf on 19-01-11.
//  Copyright 2011 Mobile Pioneers. All rights reserved.
//

#import "TransparentToolbar.h"

@implementation TransparentToolbar

// Override draw rect to avoid
// background coloring
-(void)drawRect:(CGRect)rect {
    // do nothing in here
}

// Set properties to make background
// translucent.
-(void) applyTranslucentBackground
{
	self.backgroundColor = [UIColor clearColor];
	//self.opaque = NO;
	//self.translucent = FALSE;
}

// Override init.
- (id) init
{
	self = [super init];
	[self applyTranslucentBackground];
	return self;
}

// Override initWithFrame.
- (id) initWithFrame:(CGRect) frame
{
	self = [super initWithFrame:frame];
	[self applyTranslucentBackground];
    self.barStyle = UIBarStyleBlackOpaque;
	return self;
}

@end