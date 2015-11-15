//
// CCATableViewSectionDescriptor.m
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

#import "CCATableViewSectionDescriptor.h"
#import "CCATableViewCellDescriptor.h"
#import "CCATableViewHeaderFooterView.h"

@interface CCATableViewSectionDescriptor ()

@property (nonatomic) NSMutableDictionary *headerCachedHeights;
@property (nonatomic) NSMutableDictionary *footerCachedHeights;
@property (nonatomic, copy) NSString *headerClassName;
@property (nonatomic, copy) NSString *footerClassName;
@property (nonatomic, copy) NSArray *cellDescriptors;

@end

@implementation CCATableViewSectionDescriptor

+ (instancetype)sectionDescriptorWithHeaderClass:(Class)headerClass
                                         content:(id)content
                                 cellDescriptors:(NSArray<CCATableViewCellDescriptor *> *)cellDescriptors
{
    return [[self alloc] initWithHeaderClass:headerClass
                                     content:content
                             cellDescriptors:cellDescriptors];
}

- (instancetype)initWithHeaderClass:(Class)headerClass
                        footerClass:(Class)footerClass
                      headerContent:(id)headerContent
                      footerContent:(id)footerContent
                    cellDescriptors:(NSArray<CCATableViewCellDescriptor *> *)cellDescriptors
{
    self = [super init];
    if (self) {
        _headerClassName = NSStringFromClass(headerClass);
        NSAssert(!headerClass || [headerClass isSubclassOfClass:[CCATableViewHeaderFooterView class]], @"Header class (%@) must be a subclass of CCATableViewHeaderFooterView", _headerClassName);
        
        _footerClassName = NSStringFromClass(footerClass);
        NSAssert(!footerClass || [footerClass isSubclassOfClass:[CCATableViewHeaderFooterView class]], @"Footer class (%@) must be a subclass of CCATableViewHeaderFooterView", _footerClassName);
        
        _headerContent = headerContent;
        _footerContent = footerContent;
        _cellDescriptors = cellDescriptors;
        
        if (headerClass) {
            _headerCachedHeights = [NSMutableDictionary dictionary];
        }
        if (footerClass) {
            _footerCachedHeights = [NSMutableDictionary dictionary];
        }
    }
    return self;
}


- (instancetype)initWithHeaderClass:(Class)headerClass
                            content:(id)headerContent
                    cellDescriptors:(NSArray<CCATableViewCellDescriptor *> *)cellDescriptors
{
    return [self initWithHeaderClass:headerClass
                         footerClass:Nil
                       headerContent:headerContent
                       footerContent:nil
                     cellDescriptors:cellDescriptors];
}

- (instancetype)init
{
    return [self initWithHeaderClass:[CCATableViewHeaderFooterView class]
                         footerClass:[CCATableViewHeaderFooterView class]
                       headerContent:nil
                       footerContent:nil
                     cellDescriptors:@[]];
}

- (Class)headerClass
{
    return NSClassFromString(self.headerClassName);
}

- (Class)footerClass
{
    return NSClassFromString(self.footerClassName);
}

#pragma mark - Access cell descriptors

- (NSInteger)numberOfCellsInSection
{
    return [self.cellDescriptors count];
}

- (CCATableViewCellDescriptor *)cellDescriptorAtIndex:(NSInteger)rowIndex
{
    NSAssert(rowIndex >= 0 && rowIndex < [self.cellDescriptors count], @"Row index %li is out of range for current cell descriptors (%li total)", (long)rowIndex, (long)[_cellDescriptors count]);
    return self.cellDescriptors[rowIndex];
}

#pragma mark - Dequeuing a header/footer

- (CCATableViewHeaderFooterView *)headerViewDequeuedFromTableView:(UITableView *)tableView inSection:(NSInteger)section
{
    return [self viewDequeuedFromTableView:tableView
                                 inSection:section
                                 viewClass:[self headerClass]];
}

- (CCATableViewHeaderFooterView *)footerViewDequeuedFromTableView:(UITableView *)tableView inSection:(NSInteger)section
{
    return [self viewDequeuedFromTableView:tableView
                                 inSection:section
                                 viewClass:[self footerClass]];
}

- (CCATableViewHeaderFooterView *)viewDequeuedFromTableView:(UITableView *)tableView
                                                  inSection:(NSInteger)section
                                                  viewClass:(Class)viewClass
{
    if (!viewClass) {
        return nil;
    }
    CCATableViewHeaderFooterView *view = [viewClass viewDequeuedFromTableView:tableView atSection:section];
    return view;
}

#pragma mark - Header/Footer height

- (CGFloat)headerViewHeightForTableView:(UITableView *)tableView inSection:(NSInteger)section
{
    return [self viewHeightForTableView:tableView
                              inSection:section
                              viewClass:[self headerClass]
                                content:self.headerContent
                          cachedHeights:self.headerCachedHeights];
}

- (CGFloat)footerViewHeightForTableView:(UITableView *)tableView inSection:(NSInteger)section
{
    return [self viewHeightForTableView:tableView
                              inSection:section
                              viewClass:[self footerClass]
                                content:self.footerContent
                          cachedHeights:self.footerCachedHeights];
}

- (CGFloat)viewHeightForTableView:(UITableView *)tableView
                        inSection:(NSInteger)section
                        viewClass:(Class)viewClass
                          content:(id)content
                    cachedHeights:(NSMutableDictionary *)cachedHeights
{
    if (!viewClass) {
        return 0.;
    }
    NSNumber *widthKey = @(CGRectGetWidth(tableView.frame));
    NSNumber *cachedHeight = cachedHeights[widthKey];
    if (cachedHeight) {
        return [cachedHeight doubleValue];
    }
    CGFloat height = [viewClass heightForObject:content inTableView:tableView atSection:section];
    cachedHeights[widthKey] = @(height);
    return height;
}


@end
