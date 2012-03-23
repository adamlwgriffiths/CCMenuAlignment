//
//  CCMenuAdvanced+Alignment.m
//
//  Created by Adam Griffiths on 23/03/12.
//  Copyright (c) 2012 Twisted Pair Development. All rights reserved.
//
//  twistedpairdevelopment.wordpress.com
//  @twistedpairdev
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
// 
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CCMenuAdvanced+Alignment.h"

@interface CCMenuAdvanced (Private)
- (CGSize)calculateContentSizeWithVerticalPadding:(float)padding;
@end

@implementation CCMenuAdvanced (Alignment)


- (CGSize)calculateContentSizeWithVerticalPadding:(float)padding
{
	float width = 0.0;
	float height = 0.0;
	
	// remove 1 amount of padding
	int itemCount = [children_ count];
	if ( itemCount > 0 )
	{
		height -= padding;
	}
	
	// calculate contentSize,
	CCMenuItem *item = nil;
	CCARRAY_FOREACH(children_, item)
	{
		height += item.contentSize.height * item.scaleY + padding;
		width = MAX(item.contentSize.width * item.scaleX, width);
	}
	
	return CGSizeMake(width, height);
}

- (void)alignMenuTopWithYValue:(float)y
{
	// move the menu so its tops is at the top margin
	[self setPosition:CGPointMake(
		self.position.x,
		y - (self.contentSize.height / 2.0)
		)];
}

- (void)alignMenuLeftWithXValue:(float)x
{
	// move the menu so its tops is at the top margin
	[self setPosition:CGPointMake(
		x + (self.contentSize.width / 2.0),
		self.position.y
		)];
}

- (void)alignItemsVerticallyFromTop
{
	// MAGIC: because private numbers with no accessors make us all happy =/
	[self alignItemsVerticallyFromTopWithPadding:5 bottomToTop: YES];
}

- (void)alignItemsVerticallyFromTopWithPadding:(float)padding
{
	// MAGIC: because private numbers with no accessors make us all happy =/
	[self alignItemsVerticallyFromTopWithPadding:5 bottomToTop: YES];
}

- (void)alignItemsVerticallyFromTopWithPadding:(float)padding bottomToTop:(BOOL)bottomToTop
{
	// update the content size
	// we need to do this to position our elements correctly
	// CCMenu doesn't need this, go figure
	[self setContentSize: [self calculateContentSizeWithVerticalPadding:padding]];
	// the content size is not from the position as top left, but as center
	// so be have to shuffle down half the height
	float y = [self contentSize].height / 2.0;
	float halfWidth = [self contentSize].width / 2.0;
	
	CCMenuItem *item = nil;
	CCARRAY_FOREACH(children_, item)
	{
		float currentDiff = (item.contentSize.height * item.scaleY / 2.0);
		float nextDiff = (item.contentSize.height * item.scaleY + padding);
		if ( bottomToTop == NO )
		{
			currentDiff *= -1.0;
			nextDiff *= -1.0;
		}

		float currentY = y + currentDiff;
		[item setPosition:ccp( halfWidth, currentY)];
		
		// move to the next position
	    y += nextDiff;
	}
	
#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
	if (bottomToTop)
	{
		self.nextItemButtonBind = NSUpArrowFunctionKey;
		self.prevItemButtonBind = NSDownArrowFunctionKey;
	}
	else 
	{
		self.nextItemButtonBind = NSDownArrowFunctionKey;
		self.prevItemButtonBind = NSUpArrowFunctionKey;
	}
#endif
}

@end
