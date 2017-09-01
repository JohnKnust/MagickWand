// ImageWand+Resize.swift
//
// Copyright (c) 2016 Sergey Minakov
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

import Foundation

#if os(Linux)
    import CMagickWandLinux
#else
    import CMagickWandOSX
#endif

extension ImageWand {
    
    // TODO: Resize modes. like AspectFill, AspectFit.
    // TODO: resized, rescaled -> ImageWand
    
    public func scale(toWidth width: Double) {
        self.scale(toWidth: Int(width))
    }
    
    public func scale(toWidth width: Int) {
        let ratio = Double(self.size.width) / Double(self.size.height)
        guard Int(Double(self.size.height)/ratio) > 0 else { return }
        self.scale(width: width, height: Int(Double(width)/ratio))
    }
    
    public func scale(toHeight height: Double) {
        self.scale(toHeight: Int(height))
    }
    
    public func scale(toHeight height: Int) {
        let ratio = Double(self.size.width) / Double(self.size.height)
        guard Int(Double(self.size.width)/ratio) > 0 else { return }
        self.scale(width: Int(Double(height)*ratio), height: height)
    }
    
    public func resize(toWidth width: Double, withFilter filter: MagickWand.Filter) {
        self.resize(toWidth: Int(width), withFilter: filter)
    }
    
    public func resize(toWidth width: Int, withFilter filter: MagickWand.Filter) {
        let ratio = Double(self.size.width) / Double(self.size.height)
        guard Int(Double(self.size.height)/ratio) > 0 else { return }
        self.resize(width: width, height: Int(Double(width)/ratio), filter: filter)
    }
    
    public func resize(toHeight height: Double, withFilter filter: MagickWand.Filter) {
        self.resize(toHeight: Int(height), withFilter: filter)
    }
    
    public func resize(toHeight height: Int, withFilter filter: MagickWand.Filter) {
        let ratio = Double(self.size.width) / Double(self.size.height)
        guard Int(Double(self.size.width)/ratio) > 0 else { return }
        self.resize(width: Int(Double(height)*ratio), height: height, filter: filter)
    }
    
    public func resize(width: Double, height: Double, filter: MagickWand.Filter, blur: Double = 1.0) {
        self.resize(width: Int(width), height: Int(width), filter: filter, blur: blur)
    }
    
    public func resize(width: Int, height: Int, filter: MagickWand.Filter, blur: Double = 1.0) {
        MagickResizeImage(self.pointer, width, height, filter.filter, blur)
    }
    
    public func adaptiveResize(width: Double, height: Double) {
        self.adaptiveResize(width: Int(width), height: Int(height))
    }
    
    public func adaptiveResize(width: Int, height: Int) {
        MagickAdaptiveResizeImage(self.pointer, width, height)
    }
    
    public func scale(width: Double, height: Double) {
        self.scale(width: Int(width), height: Int(width))
    }
    
    public func scale(width: Int, height: Int) {
        MagickScaleImage(self.pointer, width, height)
    }
}
