//
// CCATableViewCell.m
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

#import "CCATableViewCell.h"

@interface CCATableViewCell ()

@property (nonatomic, getter=isLastInSection) BOOL lastInSection;

@end

@implementation CCATableViewCell

+ (instancetype)prototypeCell
{
    static NSMutableDictionary *prototypeCells = nil;
    if (!prototypeCells) {
        prototypeCells = [NSMutableDictionary dictionary];
    }
    NSString *cacheKey = NSStringFromClass(self);
    CCATableViewCell *cell = prototypeCells[cacheKey];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:[self cellIdentifier] bundle:nil];
        NSArray *nibContent = [nib instantiateWithOwner:nil options:nil];
        cell = [nibContent firstObject];
        prototypeCells[cacheKey] = cell;
    }
    return cell;
}

+ (CGFloat)heightForObject:(id)object inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

+ (CGFloat)estimatedHeightForObject:(id)object inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForObject:object inTableView:tableView atIndexPath:indexPath];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass(self);
}

+ (void)registerNibForTableView:(UITableView *)tableView
{
    [self registerNibNamed:[self cellIdentifier] forTableView:tableView];
}

+ (void)registerNibNamed:(NSString *)nibName forTableView:(UITableView *)tableView
{
    NSString *cellId = [self cellIdentifier];
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellId];
}

+ (void)registerClassForTableView:(UITableView *)tableView
{
    [tableView registerClass:self forCellReuseIdentifier:[self cellIdentifier]];
}

+ (instancetype)cellDequeuedFromTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier]
                                           forIndexPath:indexPath];
}

- (void)updateIsLastInSection
{
    UIView *sv = self.superview;
    UITableView *tableView = nil;
    while (sv) {
        if ([sv isKindOfClass:[UITableView class]]) {
            tableView = (UITableView *)sv;
            break;
        }
        sv = sv.superview;
    }
    if (!tableView) {
        return;
    }
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    if (!indexPath) {
        return;
    }
    self.lastInSection = (indexPath.row == ([tableView numberOfRowsInSection:indexPath.section] - 1));
}

- (void)updateWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    [self updateColors:highlighted || [self isSelected]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self updateColors:selected || [self isHighlighted]];
}

- (void)updateColors:(BOOL)isHighlighted
{
    
}


@end
