//
// CCATableViewSectionDescriptor.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CCATableViewHeaderFooterView;
@class CCATableViewCellDescriptor;

NS_ASSUME_NONNULL_BEGIN

@interface CCATableViewSectionDescriptor : NSObject

@property (nullable, nonatomic) id headerContent;
@property (nullable, nonatomic) id footerContent;

- (nullable Class)headerClass;
- (nullable Class)footerClass;

- (nullable CCATableViewHeaderFooterView *)headerViewDequeuedFromTableView:(UITableView *)tableView
                                                                  inSection:(NSInteger)section;

- (nullable CCATableViewHeaderFooterView *)footerViewDequeuedFromTableView:(UITableView *)tableView
                                                                  inSection:(NSInteger)section;

- (CGFloat)headerViewHeightForTableView:(UITableView *)tableView inSection:(NSInteger)section;
- (CGFloat)footerViewHeightForTableView:(UITableView *)tableView inSection:(NSInteger)section;

- (instancetype)initWithHeaderClass:(nullable Class)headerClass
                        footerClass:(nullable Class)footerClass
                      headerContent:(nullable id)headerContent
                      footerContent:(nullable id)footerContent
                    cellDescriptors:(NSArray<CCATableViewCellDescriptor *> *)cellDescriptors NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithHeaderClass:(nullable Class)headerClass
                            content:(nullable id)headerContent
                    cellDescriptors:(NSArray<CCATableViewCellDescriptor *> *)cellDescriptors;

+ (instancetype)sectionDescriptorWithHeaderClass:(nullable Class)headerClass
                                         content:(nullable id)content
                                 cellDescriptors:(NSArray<CCATableViewCellDescriptor *> *)cellDescriptors;

- (CCATableViewCellDescriptor *)cellDescriptorAtIndex:(NSInteger)rowIndex;
- (NSInteger)numberOfCellsInSection;

@end

NS_ASSUME_NONNULL_END
