//
//  CCMenu+Alignment.m
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

#import "CCMenu+Alignment.h"

@implementation CCMenu (Alignment)

- (void)leftAlignItems
{
	// now we just fix up the left alignment
	CCMenuItem *item = nil;
	CCARRAY_FOREACH(children_, item)
	{
		CGPoint position = item.position;
		CGSize itemSize = item.contentSize;
	    [item setPosition:ccp( itemSize.width * item.scaleY / 2.0f, position.y )];
	}
}

- (void)rightAlignItems
{
	// now we just fix up the right alignment
	CCMenuItem *item = nil;
	CCARRAY_FOREACH(children_, item)
	{
		CGPoint position = item.position;
		CGSize itemSize = item.contentSize;
	    [item setPosition:ccp( -itemSize.width * item.scaleY / 2.0f, position.y )];
	}
}

@end
