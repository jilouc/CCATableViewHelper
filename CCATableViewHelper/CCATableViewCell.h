//
// CCATableViewCell.h
// CCATableViewHelper
//
// Copyright (c) 2015 Cocoapps (http://cocoapps.fr/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCATableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;

+ (void)registerNibForTableView:(UITableView *)tableView;
+ (void)registerNibNamed:(NSString *)nibName forTableView:(UITableView *)tableView;
+ (void)registerClassForTableView:(UITableView *)tableView;

+ (instancetype)cellDequeuedFromTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
- (void)updateWithObject:(nullable id)object atIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)heightForObject:(nullable id)object
               inTableView:(UITableView *)tableView
               atIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)estimatedHeightForObject:(nullable id)object
                        inTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)prototypeCell;

- (void)updateColors:(BOOL)isHighlighted;
- (BOOL)isLastInSection;

@end

NS_ASSUME_NONNULL_END
