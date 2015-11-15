//
// CCATableViewCellDescriptor.h
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

@class CCATableViewCell;

NS_ASSUME_NONNULL_BEGIN

@interface CCATableViewCellDescriptor : NSObject

@property (nonatomic, nullable) id content;
@property (nonatomic, nullable, copy) void (^selectBlock)(id content, NSIndexPath *indexPath);
@property (nonatomic, nullable, copy) NSDictionary *userInfo;

- (Class)cellClass;

- (CCATableViewCell *)cellDequeuedFromTableView:(UITableView *)tableView
                                    atIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)cellHeightForTableView:(UITableView *)tableView
                      atIndexPath:(NSIndexPath *)indexPath;

- (instancetype)initWithClass:(Class)cellClass
                      content:(nullable id)content
                        block:(void(^)(id _Nullable content, NSIndexPath *indexPath))selectBlock
                     userInfo:(NSDictionary *)userInfo NS_DESIGNATED_INITIALIZER;

+ (instancetype)cellDescriptorWithClass:(Class)cellClass
                                content:(nullable id)content;

+ (instancetype)cellDescriptorWithClass:(Class)cellClass
                                content:(nullable id)content
                                  block:(nullable void(^)(id _Nullable content, NSIndexPath *indexPath))selectBlock;

+ (instancetype)cellDescriptorWithClass:(Class)cellClass
                                content:(nullable id)content
                                  block:(nullable void(^)(id _Nullable content, NSIndexPath *indexPath))selectBlock
                               userInfo:(nullable NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
