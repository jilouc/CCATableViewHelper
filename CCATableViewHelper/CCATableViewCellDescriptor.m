//
// CCATableViewCellDescriptor.m
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

#import "CCATableViewCellDescriptor.h"
#import "CCATableViewCell.h"

@interface CCATableViewCellDescriptor ()

@property (nonatomic) NSMutableDictionary *cachedHeights;
@property (nonatomic, copy) NSString *cellClassName;

@end

@implementation CCATableViewCellDescriptor

+ (instancetype)cellDescriptorWithClass:(Class)cellClass
                                content:(id)content
{
    return [self cellDescriptorWithClass:cellClass content:content block:nil];
}

+ (instancetype)cellDescriptorWithClass:(Class)cellClass
                                content:(id)content
                                  block:(void (^)(id, NSIndexPath *))selectBlock
{
    return [self cellDescriptorWithClass:cellClass
                                 content:content
                                   block:selectBlock
                                userInfo:nil];
}

+ (instancetype)cellDescriptorWithClass:(Class)cellClass
                                content:(id)content
                                  block:(void(^)(id content, NSIndexPath *indexPath))selectBlock
                               userInfo:(NSDictionary *)userInfo
{
    return [[self alloc] initWithClass:cellClass content:content block:selectBlock userInfo:userInfo];
}

- (instancetype)initWithClass:(Class)cellClass
                      content:(id)content
                        block:(void(^)(id content, NSIndexPath *indexPath))selectBlock
                     userInfo:(NSDictionary *)userInfo
{
    self = [super init];
    if (self) {
        _cellClassName = NSStringFromClass(cellClass);
        NSAssert([cellClass isSubclassOfClass:[CCATableViewCell class]], @"Cell class (%@) must be a subclass of CCATableViewCell", _cellClassName);
        
        _selectBlock = selectBlock;
        _cachedHeights = [NSMutableDictionary dictionary];
        _content = content;
        _userInfo = userInfo;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithClass:[CCATableViewCell class] content:nil block:nil userInfo:nil];
}

- (Class)cellClass
{
    return NSClassFromString(self.cellClassName);
}

- (CGFloat)cellHeightForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [self cellClass];
    NSAssert([cellClass isSubclassOfClass:[CCATableViewCell class]], @"Cell class (%@) must be a subclass of CCATableViewCell", self.cellClassName);
    
    NSNumber *widthKey = @(CGRectGetWidth(tableView.frame));
    NSNumber *cachedHeight = self.cachedHeights[widthKey];
    if (cachedHeight) {
        return [cachedHeight doubleValue];
    }
    CGFloat height = [cellClass heightForObject:self.content inTableView:tableView atIndexPath:indexPath];
    self.cachedHeights[widthKey] = @(height);
    return height;
}

- (CCATableViewCell *)cellDequeuedFromTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [self cellClass];
    NSAssert([cellClass isSubclassOfClass:[CCATableViewCell class]], @"Cell class (%@) must be a subclass of CCATableViewCell", self.cellClassName);
    
    CCATableViewCell *cell = [cellClass cellDequeuedFromTableView:tableView atIndexPath:indexPath];
    return cell;
}

@end
